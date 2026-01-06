import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/stroge/storage_service.dart';
import 'package:alpha_club/core/stroge/stroge_key.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;

  Future<void> login() async {
    if (phoneNumber.value.isEmpty || password.value.isEmpty) {
      AppLogger.warning(
        'Login attempt with empty fields',
        tag: 'LOGIN_VALIDATION',
      );
      Get.snackbar('Error', 'Please enter phone number and password');
      return;
    }

    isLoading.value = true;
    AppLogger.logUserAction(
      action: 'Login Attempt',
      data: {'phone': phoneNumber.value},
      tag: 'LOGIN',
    );

    final body = {
      'phone': phoneNumber.value,
      'password': password.value,
    };

    final response = await ApiService.post(
      ApiEndPoint.login,
      body: body,
    );

    isLoading.value = false;

    if (response.isSuccess) {
      // Save token to local storage
      final token = response.data['token'] ?? '';
      await LocalStorage.setString(LocalStorageKeys.token, token);
      
      AppLogger.info(
        'Login successful',
        tag: 'LOGIN_SUCCESS',
      );
      AppLogger.logNavigation(
        from: 'LoginScreen',
        to: 'HomeScreen',
        tag: 'NAVIGATION',
      );
      
      // Navigate to home
      Get.offAllNamed(AppRoute.homeScreen);
    } else {
      AppLogger.error(
        'Login failed: ${response.message}',
        tag: 'LOGIN_ERROR',
      );
      Get.snackbar('Error', response.message);
    }
  }
}
