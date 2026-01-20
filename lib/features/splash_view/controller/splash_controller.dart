import 'dart:async';
import 'package:get/get.dart';
import '../../../core/route/app_route.dart';
import '../../../core/stroge/storage_service.dart';
import '../../../core/service/logger/app_logger.dart';

class SplashController extends GetxController {
  var progressValue = 0.0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startProgress();
  }

  void startProgress() {
    const totalDuration = Duration(seconds: 3);
    const tickDuration = Duration(milliseconds: 50);
    double increment =
        tickDuration.inMilliseconds / totalDuration.inMilliseconds;

    _timer = Timer.periodic(tickDuration, (timer) {
      if (progressValue.value < 1.0) {
        progressValue.value += increment;
      } else {
        _timer?.cancel();
        checkAuthAndNavigate();
      }
    });
  }

  /// Check if user is logged in and navigate accordingly
  void checkAuthAndNavigate() {
    final token = LocalStorage.token;
    final isLogIn = LocalStorage.isLogIn;
    
    // Fix inconsistent state: if isLogIn is true but no token, clear login status
    if (isLogIn && token.isEmpty) {
      AppLogger.warning(
        'Inconsistent auth state detected: isLogIn=true but no token. Clearing login status.',
        tag: 'SPLASH_AUTH',
      );
      LocalStorage.isLogIn = false;
    }
    
    if (token.isNotEmpty) {
      // User is logged in, go to home
      AppLogger.info(
        'User is authenticated, navigating to Home',
        tag: 'SPLASH_AUTH',
      );
      AppLogger.logNavigation(
        from: 'SplashScreen',
        to: 'HomeScreen',
        arguments: {'reason': 'Token found'},
        tag: 'NAVIGATION',
      );
      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      AppLogger.info(
        'User is not authenticated, navigating to Login',
        tag: 'SPLASH_AUTH',
      );
      AppLogger.logNavigation(
        from: 'SplashScreen',
        to: 'LoginScreen',
        arguments: {'reason': 'No token found'},
        tag: 'NAVIGATION',
      );
      Get.offAllNamed(AppRoute.loginScreen);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
