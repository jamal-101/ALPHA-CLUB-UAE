import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PasswordController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var password = "".obs;
  var isLengthValid = false.obs;
  var hasNumbers = false.obs;
  var hasLetters = false.obs;
  var hasSpecialChars = false.obs;
  var isPasswordMatch = true.obs;

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
}