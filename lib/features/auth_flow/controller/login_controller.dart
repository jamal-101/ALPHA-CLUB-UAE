import 'package:alpha_club/features/auth_flow/presentation/widget/new_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import '../../../core/helper/from_validation.dart';
import 'dart:async';

import '../../../core/stroge/storage_service.dart';
import '../../../core/stroge/stroge_key.dart';
import '../presentation/widget/renew_dialog.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  // var phoneNumber = ''.obs;
  // var password = ''.obs;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Future<void> login() async {
  //   if (phoneNumber.value.isEmpty || password.value.isEmpty) {
  //     AppLogger.warning(
  //       'Login attempt with empty fields',
  //       tag: 'LOGIN_VALIDATION',
  //     );
  //     Get.snackbar('Error', 'Please enter phone number and password');
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //   AppLogger.logUserAction(
  //     action: 'Login Attempt',
  //     data: {'phone': phoneNumber.value},
  //     tag: 'LOGIN',
  //   );
  //
  //   final body = {
  //     'phone': phoneNumber.value,
  //     'password': password.value,
  //   };
  //
  //   final response = await ApiService.post(
  //     ApiEndPoint.login,
  //     body: body,
  //   );
  //
  //   isLoading.value = false;
  //
  //   if (response.isSuccess) {
  //     AppLogger.debug(
  //       'Login response data structure: ${response.data}',
  //       tag: 'LOGIN_DEBUG',
  //     );
  //
  //     // Token is nested inside data object
  //     final dataObject = response.data['data'] ?? {};
  //     final token = dataObject['token'] ?? '';
  //
  //     //>>>>>>>>>>>>>>>>>>>> print token  <<<<<<<<<<<<<<<<<//
  //
  //     debugPrint("---------- TOKEN START ----------");
  //     debugPrint(token);
  //     debugPrint("---------- TOKEN END ----------");
  //
  //     if (token.isEmpty) {
  //       AppLogger.warning(
  //         'Token is empty in response. Response structure: ${response.data}',
  //         tag: 'LOGIN_WARNING',
  //       );
  //     }
  //
  //     await LocalStorage.setString(LocalStorageKeys.token, token);
  //     await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
  //
  //     // Update static variables
  //     LocalStorage.token = token;
  //     LocalStorage.isLogIn = true;
  //
  //     AppLogger.info(
  //       'Token saved to storage - Length: ${token.length}, Preview: ${token.length > 10 ? '${token.substring(0, 10)}...' : token}',
  //       tag: 'LOGIN_TOKEN',
  //     );
  //
  //     if (dataObject['user'] != null) {
  //       final user = dataObject['user'];
  //       if (user['id'] != null) {
  //         await LocalStorage.setString(LocalStorageKeys.userId, user['id'].toString());
  //         LocalStorage.userId = user['id'].toString();
  //       }
  //       if (user['name'] != null) {
  //         await LocalStorage.setString(LocalStorageKeys.myName, user['name']);
  //         LocalStorage.myName = user['name'];
  //       }
  //       if (user['email'] != null) {
  //         await LocalStorage.setString(LocalStorageKeys.myEmail, user['email']);
  //         LocalStorage.myEmail = user['email'];
  //       }
  //     }
  //
  //     AppLogger.info(
  //       'Login successful - Token saved',
  //       tag: 'LOGIN_SUCCESS',
  //     );
  //     AppLogger.logNavigation(
  //       from: 'LoginScreen',
  //       to: 'HomeScreen',
  //       tag: 'NAVIGATION',
  //     );
  //
  //     if (response.isSuccess) {
  //       final dataObject = response.data['data']["user"]?? {};
  //       bool hasPasswordSave = dataObject['hasPasswordSave'] ?? true;
  //       await LocalStorage.setBool('hasPasswordSave', hasPasswordSave);
  //       Get.offAllNamed(AppRoute.homeScreen);
  //     }
  //     else if (response.statusCode == 403) {
  //       Get.dialog(
  //         Dialog(
  //           backgroundColor: Colors.transparent,
  //           child: RenewDialog(),
  //         ),
  //         barrierDismissible: false,
  //       );
  //    }
  //     else {
  //     AppLogger.error(
  //       'Login failed: ${response.message}',
  //       tag: 'LOGIN_ERROR',
  //     );
  //     Get.snackbar('Incorrect', response.message,colorText: Colors.red,backgroundColor: Colors.white);
  //   }
  //     }
  // }


  Future<void> login() async {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      AppLogger.warning('Login attempt with empty fields', tag: 'LOGIN_VALIDATION');
      Get.snackbar('Error', 'Please enter phone number and password');
      return;
    }

    try {
      isLoading.value = true;
      final response = await ApiService.post(
        ApiEndPoint.login,
        body: {
          'phone': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (response.isSuccess) {
        final dataObject = response.data['data'] ?? {};
        final token = dataObject['token'] ?? '';
        final user = dataObject['user'] ?? {};

        if (token.isNotEmpty) {
          await LocalStorage.setString(LocalStorageKeys.token, token);
          await LocalStorage.setBool(LocalStorageKeys.isLogIn, true);
          LocalStorage.token = token;
          LocalStorage.isLogIn = true;
        }

        if (user.isNotEmpty) {
          await LocalStorage.setString(LocalStorageKeys.userId, user['id'].toString());
          await LocalStorage.setBool('hasPasswordSave', user['hasPasswordSave'] ?? true);
        }

        AppLogger.info('Login successful - Token Saved', tag: 'LOGIN_SUCCESS');

        Get.dialog(const NewPasswordDialog());
        Get.offAllNamed(AppRoute.homeScreen);

      } else {
        if (response.statusCode == 403) {
          Get.dialog(
            Dialog(backgroundColor: Colors.transparent, child: RenewDialog()),
            barrierDismissible: false,
          );
        } else {
          Get.snackbar("Login Failed", response.message ?? "Invalid credentials");
        }
      }
    } catch (e) {
      if (e.toString().contains("403")) {
        Get.dialog(
          Dialog(backgroundColor: Colors.transparent, child: RenewDialog()),
          barrierDismissible: false,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

///>>>>>>>>>>>>>>>>>>>>> forgotEmail <<<<<<<<<<<<<<<<<<<<<<<//

  final forgotEmailController = TextEditingController();

  Future<void> sendForgotPasswordOtp() async {
    if (forgotEmailController.text.isEmpty || !GetUtils.isEmail(forgotEmailController.text)) {
      Get.snackbar("Error", "Please enter a valid email address",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> body = {
      "email": forgotEmailController.text.trim(),
    };

    final response = await ApiService.post(
      ApiEndPoint.forgetPassword,
      body: body,
    );

    response.handleResponse(
      onSuccess: (data) {
        Get.snackbar("Success", "OTP sent to your email",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(AppRoute.singInOtp, arguments: forgotEmailController.text.trim());
      },
    );

    isLoading.value = false;
  }


  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> otpController <<<<<<<<<<<<<<<<<<<<<<<<//

  final otpController = TextEditingController();

  var otpError = ''.obs;

  Future<void> verifyOtp() async {
    String? validationError = FormValidation.validatePin(otpController.text);

    if (validationError != null) {
      otpError.value = validationError;
      return;
    }
    otpError.value = '';
    isLoading.value = true;

    Map<String, dynamic> body = {
      "email": forgotEmailController.text.trim(),
      "oneTimeCode": otpController.text.trim(),
    };

    final response = await ApiService.post(
      ApiEndPoint.verifyResetOtp,
      body: body,
    );

    if (response.isSuccess) {
      Get.snackbar("Success", "OTP Verified Successfully",
          backgroundColor: Colors.white, colorText: Colors.green);
      Get.toNamed(AppRoute.newPasswordScreen);
    } else {
      otpError.value = response.message ?? "Invalid OTP";
    }

    isLoading.value = false;
  }


  ///>>>>>>>>>>>>>>>>>>>>>> resend otp <<<<<<<<<<<<<<<<<<<<<///

  var secondsRemaining = 180.obs;
  var enableResend = false.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }



  void startTimer() {
    secondsRemaining.value = 180;
    enableResend.value = false;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        t.cancel();
      }
    });
  }

  Future<void> resendOtp() async {
    if (enableResend.value) {
      await sendForgotPasswordOtp();
      startTimer();
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();

    timer?.cancel();
    forgotEmailController.dispose();
    otpController.dispose();
    super.onClose();
  }

  ///>>>>>>>>>>>>>>>>>>> send renew request <<<<<<<<<<<<<<<<<<<<///


  Future<void> sendRenewalRequest() async {
    try {
      final Map<String, dynamic> body = {
        'phone': phoneController.text.trim(),
      };

      AppLogger.info('Sending Renewal Request for: ${phoneController.text.trim()}');

      final response = await ApiService.post(
        '/auth/renewal-request',
        body: body,
      );

      if (response.isSuccess) {
        passwordController.clear();
        Get.back();
        Get.snackbar(
            'Success',
            'Your renewal request has been sent.',
            backgroundColor: Colors.green,
            colorText: Colors.white
        );
      }
    } catch (e) {
      AppLogger.error('Renewal Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

}

// Future<void> handleUnauthorized() async {
//   await LocalStorage.clear();
//   Get.offAllNamed(AppRoute.loginScreen);
//   Get.snackbar(
//       "Session Expired",
//       "Please login again to continue.",
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//       snackPosition: SnackPosition.BOTTOM
//   );
// }
