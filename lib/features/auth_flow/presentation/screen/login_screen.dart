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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.homeScreen);
                      },
                      child: Container(
                        height: 27.h,
                        width: 57.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.skipColor,
                          )
                        ),child: Center(
                          child: CommonText(
                          fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.skipColor,
                            text: "Skip"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Image.asset(AssetPath.splashImage, height: 132, width: 267),
              CommonText(
                text: AppString.sinIn,
                color: AppColors.whiteFoundation,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
              ),
              SizedBox(height: 10.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.enterYourMobile,
                color: AppColors.whiteFoundation,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              SizedBox(height: 2.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.toAccess,
                color: AppColors.whiteFoundation,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              SizedBox(height: 34.h),
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
                        SizedBox(height: 85.h),
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro'
                          ),
                          text: AppString.contactNumber,
                        ),
                        SizedBox(height: 12.h),
                        CommonTextField(
                          prefixIcon: Image.asset(AssetPath.mobileIcon),
                          // isPassword: true,
                          hintText: AppString.enterYourContact,
                        ),
                        SizedBox(height: 24.h),
                        CommonText(
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro'
                          ),
                          text: AppString.contactNumber,
                        ),
                        SizedBox(height: 12.h),
                        CommonTextField(
                          isPassword: true,
                          hintText: '********',
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.newPasswordScreen);
                              },
                              child: CommonText(
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blue1,
                                    fontFamily: 'SFPro'
                                ),
                                text: AppString.forgetPass,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        CommonButton(onTap: (){
                          Get.toNamed(AppRoute.singInOtp);
                        }, text: AppString.sinIn),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.blue1,
                                ),
                                text: AppString.becomeAnd),
                            SizedBox(width: 10.w),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.linearGradient1,
                                  AppColors.linearGradient2,
                                ],
                              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                              child: GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoute.memberFormScreen);
                                },
                                child: Text(
                                  AppString.applyHere,
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFDFBB0B)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // CommonBottomNabVar(selectedIndex: 2)
            ],
          ),
        ),
      ),
    );
  }
}
