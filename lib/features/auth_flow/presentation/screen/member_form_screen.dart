import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/global/drop_down_type.dart';
import 'package:alpha_club/core/global/message_field.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/controller/auth_controller.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/common_text_field.dart';
import '../../../../core/global/custom_phone_field.dart';
import '../../../../core/helper/from_validation.dart';
import '../../../../core/utils/app_color/app_color.dart';

class MemberFormScreen extends StatelessWidget {
  MemberFormScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());
 final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  CommonAppBar(
                    title: "Membership Enquiry",
                    onTap: () {
                      Get.toNamed(AppRoute.loginScreen);
                    },
                  ),
                  SizedBox(height: 24.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      fontFamily: 'SFPro',
                    ),
                    text: AppString.fullName,
                  ),
                  SizedBox(height: 12.h),
                  CommonTextField(
                    validator: FormValidation.validateUsername,
                    controller: authController.nameController,
                    borderColor: AppColors.otpBorderColor,
                    containerColor: AppColors.appBackgroundColor,
                    hintText: AppString.enterYOurName,
                  ),
                  SizedBox(height: 12.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      fontFamily: 'SFPro',
                    ),
                    text: AppString.contactNumber,
                  ),
                  SizedBox(height: 12.h),
                  CustomPhoneField(
                    validator: FormValidation.validatePhoneNumber,
                    hintText: "09 -1897243189",
                    onNumberChanged: (phone) {
                      debugPrint("Full Number: ${phone.completeNumber}");
                      authController.phoneNumber.value = phone.completeNumber;
                    },
                  ),
                  // SizedBox(height: 24.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      fontFamily: 'SFPro',
                    ),
                    text: AppString.email,
                  ),
                  SizedBox(height: 12.h),
                  CommonTextField(
                    validator: FormValidation.validateEmail,
                    controller: authController.emailController,
                    borderColor: AppColors.otpBorderColor,
                    containerColor: AppColors.appBackgroundColor,
                    hintText: AppString.enterEmail,
                  ),
                  SizedBox(height: 24.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      fontFamily: 'SFPro',
                    ),
                    text: "Choose membership",
                  ),
                  SizedBox(height: 12.h),
                  DropDownType(),
                  SizedBox(height: 24.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      fontFamily: 'SFPro',
                    ),
                    text: AppString.message,
                  ),
                  SizedBox(height: 12.h),
                  MessageField(
                    containerColor: AppColors.appBackgroundColor,
                    fillColor: AppColors.appBackgroundColor,
                    textController: authController.messageController,
                  ),
                  SizedBox(height: 16.h),
                  Obx(() => CommonButton(
                    onTap: () {
                      if (authController.isLoading.value) return;
                      // authController.createContactForm();
                      if (_formKey.currentState!.validate()) {
                        authController.createContactForm();
                      }
                    },
                    text: authController.isLoading.value ? "Loading..." : "Submit",
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
