import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/route/app_route.dart';
import '../../../core/service/api/api_service.dart';
import '../../profile_flow/controller/profile_controller.dart';

enum MemberType { alpha, alphaFamily }

class AuthController extends GetxController {
  var isLoading = false.obs;
  var selectedMemberType = "Select".obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  var phoneNumber = "".obs;


  @override
  void onClose() {
    // nameController.dispose();
    // emailController.dispose();
    // messageController.dispose();
    super.onClose();
  }

  final ProfileController profileController = Get.find<ProfileController>();

  Future<void> createContactForm() async {
    isLoading.value = true;
    Map<String, dynamic> bodyData = {
      "name": nameController.text.trim(),
      "contact": phoneNumber.value,
      "email": emailController.text.trim(),
      "message": messageController.text.trim().isEmpty ? "" : messageController.text.trim(),
      // "membershipType": selectedMemberType.value == "Select" ? "" : selectedMemberType.value.toLowerCase(),
      "membershipType": profileController.selectedMemberTypeCode.value,
    };

    final response = await ApiService.post(
      ApiEndPoint.contactForm,
      body: bodyData,
    );

    response.handleResponse(
      onSuccess: (responseData) {
        Get.snackbar("Success", "Contact form created successfully",
            backgroundColor: Colors.white, colorText: Colors.black);
        nameController.clear();
        emailController.clear();
        messageController.clear();
        Get.toNamed(AppRoute.loginScreen);
      },
    );
    isLoading.value = false;
  }
}