import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/helper/from_validation.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controller/new_passWord_controller.dart';


class NewPasswordScreen extends StatelessWidget {
     NewPasswordScreen({super.key});


  final PasswordController newPassController = Get.put(PasswordController());
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 70.h),
              Image.asset(AssetPath.splashImage, height: 130, width: 267),
              SizedBox(height: 50.h),
              CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  color: AppColors.whiteFoundation,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
                text: AppString.createNewPass,
              ),
              SizedBox(height: 10.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.yourNewPass,
                color: AppColors.whiteFoundation1,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.previous,
                color: AppColors.whiteFoundation1,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.r),
                      topRight: Radius.circular(45.r),
                    ),
                    color: AppColors.appBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),
                            CommonText(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue1,
                                  fontFamily: 'SFPro'
                              ),
                              text: AppString.newPassword,
                            ),
                            SizedBox(height: 12.h),
                            // CommonTextField(
                            //   // validator: FormValidation.validatePassword,
                            //   controller: newPassController.passwordController,
                            //   onChanged: (value) => newPassController.validatePassword(value),
                            //   isPassword: true,
                            //   hintText: '********',
                            // ),
                            CommonTextField(
                              validator: (value) => FormValidation.validatePassword(value),
                              controller: newPassController.passwordController,
                              onChanged: (value) => newPassController.validatePassword(value),
                              isPassword: true,
                              hintText: '********',
                            ),
                            SizedBox(height: 20.h),
                            CommonText(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue1,
                                  fontFamily: 'SFPro'
                              ),
                              text: AppString.confirmNewPass,
                            ),
                            SizedBox(height: 12.h),
                            // CommonTextField(
                            //   // validator: FormValidation.confirmPasswordValidator(value, changePassController),
                            //   controller: newPassController.confirmPasswordController,
                            //   isPassword: true,
                            //   hintText: '********',
                            //   onChanged: (value) => newPassController.checkPasswordMatch(),
                            // ),
                            CommonTextField(
                              validator: (value) => FormValidation.confirmPasswordValidator(
                                  value,
                                  newPassController.passwordController
                              ),
                              controller: newPassController.confirmPasswordController,
                              isPassword: true,
                              hintText: '********',
                              onChanged: (value) => newPassController.checkPasswordMatch(),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                validationRow("At least 8 characters", newPassController.isLengthValid),
                                validationRow("Numbers (0-9)", newPassController.hasNumbers),
                                validationRow("Upper & Lower case letters", newPassController.hasLetters),
                                validationRow("Special characters", newPassController.hasSpecialChars),
                              ],
                            ),
                            SizedBox(height: 58.h),
                            Obx(() => CommonButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (!newPassController.isLoading.value) {
                                    newPassController.resetPassword();
                                  }
                                }
                              },
                              text: newPassController.isLoading.value ? "Updating..." : AppString.cont,
                            )),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget validationRow(String title, RxBool isValid) {
  return Obx(() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(
          isValid.value ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isValid.value ? AppColors.green1 : AppColors.blueBase,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'SFPro',
            color: isValid.value ? AppColors.green1 : AppColors.blueBase,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    ),
  ));
}
