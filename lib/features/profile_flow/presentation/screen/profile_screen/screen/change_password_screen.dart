import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../../core/helper/from_validation.dart';
import '../../../../controller/profile_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
      ChangePasswordScreen({super.key});

      final ProfileController controller = Get.put(ProfileController(),permanent: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blue1,
            size: 20.sp,
          ),
        ),
        title: CommonText(
          text: AppString.changePassword,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: AppColors.blue1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 20,right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CommonText(
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SFPro',
                    color: AppColors.blue1,
                  ),
                    text: AppString.currentPassword),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: controller.currentPasswordController,
                  isPopins: true,
                    isPassword: true,
                  hintText: AppString.currentPassword,
                  validator: (value) => FormValidation.validatePassword(value),
                ),
                SizedBox(height: 24.h),
                CommonText(
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'SFPro',
                      color: AppColors.blue1,
                    ),
                    text: AppString.newPassword),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: controller.newPasswordController,
                  validator: (value) => FormValidation.validatePassword(value),
                  isPopins: true,
                  isPassword: true,
                  hintText: AppString.newPassword,
                ),
                SizedBox(height: 24.h),
                CommonText(
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'SFPro',
                      color: AppColors.blue1,
                    ),
                    text: AppString.confirmPassword),
                SizedBox(height: 12.h),
                CommonTextField(
                  controller: controller.confirmPasswordController,
                  isPopins: true,
                  isPassword: true,
                  hintText: AppString.confirmPassword,
                  validator: (value) => FormValidation.validatePasswordMatch(value, controller.newPasswordController),
                ),
                SizedBox(height: 370.h),
                Obx(() => CommonButton(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      controller.changePassword(context);
                    }
                  },
                  text: controller.isLoading.value ? "Loading..." : AppString.save,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
