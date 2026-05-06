import 'dart:async';
import 'package:get/get.dart';
import '../../summary/views/summarizer_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToHome();
  }

  void goToHome() {
    Timer(const Duration(seconds: 4), () {
      Get.off(() => SummarizerScreen());
    });
  }
}
