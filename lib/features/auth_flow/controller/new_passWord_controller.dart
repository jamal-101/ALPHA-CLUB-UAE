import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_service.dart';
import '../presentation/widget/new_password_dialog.dart';
import 'login_controller.dart';

class PasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var password = "".obs;
  var isLengthValid = false.obs;
  var hasNumbers = false.obs;
  var hasLetters = false.obs;
  var hasSpecialChars = false.obs;
  var isPasswordMatch = true.obs;
  var isLoading = false.obs;

  void validatePassword(String value) {
    password.value = value;
    isLengthValid.value = value.length >= 8;
    hasNumbers.value = value.contains(RegExp(r'[0-9]'));
    hasLetters.value = value.contains(RegExp(r'[a-z]')) && value.contains(RegExp(r'[A-Z]'));
    hasSpecialChars.value = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    checkPasswordMatch();
  }

  void checkPasswordMatch() {
    String p1 = passwordController.text;
    String p2 = confirmPasswordController.text;

    if (p2.isEmpty) {
      isPasswordMatch.value = true;
    } else {
      isPasswordMatch.value = (p1 == p2);
    }
  }


  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }



  Future<void> resetPassword() async {

    isLoading.value = true;
    final loginController = Get.find<LoginController>();

    Map<String, dynamic> body = {
      "otp": loginController.otpController.text.trim(),
      "newPassword": passwordController.text.trim(),
      "confirmPassword": confirmPasswordController.text.trim(),
    };

    final response = await ApiService.post(
      ApiEndPoint.resetPassword,
      body: body,
    );

    if (response.isSuccess) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: const NewPasswordDialog(),
        ),
      );
    } else {
      Get.snackbar("Error", response.message ?? "Failed to reset password",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    isLoading.value = false;
  }
}