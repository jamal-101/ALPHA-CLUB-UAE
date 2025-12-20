import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 159.h),
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue,
                              fontFamily: 'SFPro'
                          ),
                          text: AppString.newPassword,
                        ),
                        SizedBox(height: 12.h),
                        CommonTextField(
                          isPassword: true,
                          hintText: '********',
                        ),
                        SizedBox(height: 20.h),
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue,
                              fontFamily: 'SFPro'
                          ),
                          text: AppString.confirmNewPass,
                        ),
                        SizedBox(height: 12.h),
                        CommonTextField(
                          isPassword: true,
                          hintText: '********',
                        ),
                        SizedBox(height: 60.h),
                        CommonButton(onTap: (){
                          // Get.toNamed(AppRoute.);
                        }, text: AppString.sendOtp),
                        SizedBox(height: 40.h),
                      ],
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
