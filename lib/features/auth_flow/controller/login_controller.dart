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
      AppLogger.debug(
        'Login response data structure: ${response.data}',
        tag: 'LOGIN_DEBUG',
      );
      
      // Token is nested inside data object
      final dataObject = response.data['data'] ?? {};
      final token = dataObject['token'] ?? '';
      
      if (token.isEmpty) {
        AppLogger.warning(
          'Token is empty in response. Response structure: ${response.data}',
          tag: 'LOGIN_WARNING',
        );
      }
      
      await LocalStorage.setString(LocalStorageKeys.token, token);
      await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
      
      // Update static variables
      LocalStorage.token = token;
      LocalStorage.isLogIn = true;
      
      AppLogger.info(
        'Token saved to storage - Length: ${token.length}, Preview: ${token.length > 10 ? '${token.substring(0, 10)}...' : token}',
        tag: 'LOGIN_TOKEN',
      );
      
      // Save user data if available
      if (dataObject['user'] != null) {
        final user = dataObject['user'];
        if (user['id'] != null) {
          await LocalStorage.setString(LocalStorageKeys.userId, user['id'].toString());
          LocalStorage.userId = user['id'].toString();
        }
        if (user['name'] != null) {
          await LocalStorage.setString(LocalStorageKeys.myName, user['name']);
          LocalStorage.myName = user['name'];
        }
        if (user['email'] != null) {
          await LocalStorage.setString(LocalStorageKeys.myEmail, user['email']);
          LocalStorage.myEmail = user['email'];
        }
      }
      
      AppLogger.info(
        'Login successful - Token saved',
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
