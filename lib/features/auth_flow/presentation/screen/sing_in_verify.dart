import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/helper/from_validation.dart';
import '../../../../core/route/app_route.dart';


class SingInVerify extends StatelessWidget {
      SingInVerify({super.key});


  final LoginController phoneController = Get.put(LoginController());
      final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              SizedBox(height: 90.h),
              Image.asset(AssetPath.splashImage, height: 132, width: 267),
              SizedBox(height: 70.h),
              CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  color: AppColors.whiteFoundation,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
                text: AppString.forgetPass,
              ),
              SizedBox(height: 10.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.enterYourMobile,
                color: AppColors.whiteFoundation1,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              SizedBox(height: 55.h),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 159.h),
                            CommonText(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue1,
                                  fontFamily: 'SFPro'
                              ),
                              text: AppString.email,
                            ),
                            SizedBox(height: 12.h),
                            CommonTextField(
                              validator: FormValidation.validateEmail,
                              controller: phoneController.forgotEmailController,
                              borderColor: AppColors.otpBorderColor,
                              containerColor: AppColors.appBackgroundColor,
                              hintText: AppString.enterEmail,
                            ),
                            SizedBox(height: 60.h),
                            Obx(() => CommonButton(
                              // isLoading: phoneController.isLoading.value,
                              onTap: () {
                                Get.toNamed(AppRoute.singInOtp);
                                if (!phoneController.isLoading.value) {
                                  phoneController.sendForgotPasswordOtp();
                                }
                              },
                              text: phoneController.isLoading.value ? "Sending..." : AppString.sendOtp,
                            )),
                            // CommonButton(onTap: (){
                            //   Get.toNamed(AppRoute.singInOtp);
                            // }, text: AppString.sendOtp),
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
