import 'package:ai_summarizer_app/summary/controller/summarizer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SummarizerScreen extends StatelessWidget {
  final controller = Get.put(SummarizerController());

  SummarizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Summarize Your Text"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // INPUT CARD
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: TextField(
                controller: controller.textController,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: "Paste/Write your text here...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<int>(
                value: controller.selectedLines.value,
                isExpanded: true,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 3, child: Text("3 Lines Summary")),
                  DropdownMenuItem(value: 5, child: Text("5 Lines Summary")),
                  DropdownMenuItem(value: 10, child: Text("10 Lines Summary")),
                  DropdownMenuItem(
                    value: 99,
                    child: Text("Bullet Points Summary"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedLines.value = value;
                  }
                },
              ),
            )),



            const SizedBox(height: 20),

            // BUTTON
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.summarizeText,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.black,
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text("Summarize",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ), ),
              ),
            )),

            const SizedBox(height: 20),

            // OUTPUT
            Obx(() {
              if (controller.summary.isEmpty &&
                  controller.isLoading.value == false) {
                return const Text(
                  "Your summary will appear here...",
                  style: TextStyle(color: Colors.grey),
                );
              }

              if (controller.isLoading.value) {
                return const Expanded(
                  child: Center(child: Text("Generating summary...")),
                );
              }

              return Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // HEADER ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Summary",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              // copy logic later
                            },
                          )
                        ],
                      ),

                      const Divider(),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            controller.summary.value,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}