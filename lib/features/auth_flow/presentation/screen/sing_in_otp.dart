import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class SingInOtp extends StatelessWidget {
  const SingInOtp({super.key});

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 159.h),
                        Pinput(
                          length: 4,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // controller: singUpOtpController.singUpOtp,
                          // validator: FormValidation.validatePin,
                          defaultPinTheme: PinTheme(
                            height: 60.h,
                            width: 60.w,
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                            textStyle: TextStyle(
                              fontFamily: 'SFPro',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: AppColors.otpFillColor,
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.otpBorderColor,
                              ),
                            ),
                          ),
                          preFilledWidget: Text(
                            '-',
                            style: TextStyle(
                              fontFamily: 'SFPro',
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue,
                            ),
                          ),
                          onCompleted: (value) {
                            // otpController.otpController.text = value;
                            // errorMessage.value = '';
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // errorMessage.value = '';
                            }
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue,
                              ),
                                text:AppString.resendCodeIn),
                            SizedBox(width: 6.w),
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.yellow,
                                ),
                                text:AppString.second),
                          ],
                        ),
                        SizedBox(height: 60.h),
                        CommonButton(onTap: (){
                          Get.toNamed(AppRoute.newPasswordScreen);
                        }, text: AppString.verifyCode),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                text:AppString.donTReceive),
                            SizedBox(width: 15.w),
                            CommonText(
                                text:AppString.resendCode,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.yellow,
                            ),
                          ],
                        )
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
