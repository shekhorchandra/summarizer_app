import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SummarizerController extends GetxController {
  final textController = TextEditingController();

  var summary = "".obs;
  var isLoading = false.obs;
  var selectedLines = 5.obs;
  var selectedType = 0.obs; // 0 = normal, 99 = bullet

  String getPrompt() {
    if (selectedType.value == 99) {
      return """
Convert this text into bullet points:
- Short and clear points only

${textController.text}
""";
    } else {
      return "Summarize this text in ${selectedLines.value} lines:\n${textController.text}";
    }
  }

  Future<void> summarizeText() async {
    if (textController.text.isEmpty) return;

    isLoading.value = true;
    summary.value = "";

    try {
      final apiKey = "AIzaSyB1xcSfqmQnamVlM4_BIU1wBOGVLa-Nuzk";

      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=$apiKey",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      """
Convert the following text into bullet points.
- Each bullet should be short
- Keep important information only
- Do not add extra explanation

Text:
${textController.text}
""",
                },
              ],
            },
          ],
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data["candidates"] != null &&
          data["candidates"].isNotEmpty) {
        summary.value = data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        summary.value = data["error"]?["message"] ?? "Something went wrong";
      }
    } catch (e) {
      summary.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
