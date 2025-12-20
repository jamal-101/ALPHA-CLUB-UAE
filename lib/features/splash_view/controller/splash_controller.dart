import 'dart:async';
import 'package:get/get.dart';

import '../../../core/route/app_route.dart';

class SplashController extends GetxController {
  var progressValue = 0.0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startProgress();
  }

  void startProgress() {
    const totalDuration = Duration(seconds: 5);
    const tickDuration = Duration(milliseconds: 50);
    double increment =
        tickDuration.inMilliseconds / totalDuration.inMilliseconds;

    _timer = Timer.periodic(tickDuration, (timer) {
      if (progressValue.value < 1.0) {
        progressValue.value += increment;
      } else {
        _timer?.cancel();
        Get.offAllNamed(AppRoute.loginScreen);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
