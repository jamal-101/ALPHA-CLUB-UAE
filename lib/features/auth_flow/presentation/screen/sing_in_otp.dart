import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/common_button.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/route/app_route.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../../../core/utils/app_string/app_string.dart';
import '../../controller/login_controller.dart';

class SingInOtp extends StatelessWidget {
  SingInOtp({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.radialGradiant2,
        surfaceTintColor: AppColors.radialGradiant2,
        elevation: 0,
        leadingWidth: 50.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.white70.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 9.w),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87.withValues(alpha: 0.9),
                    size: 28.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: 90.h),
              Image.asset(AssetPath.splashImage, height: 130, width: 240),
              SizedBox(height: 70.h),
              CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  color: AppColors.whiteFoundation,
                  fontWeight: FontWeight.w400,
                  fontSize: 20.sp,
                ),
                text: AppString.enderDigit,
              ),
              SizedBox(height: 10.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.enterThemFourDigit,
                color: AppColors.whiteFoundation1,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              SizedBox(height: 55.h),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.r),
                    topRight: Radius.circular(45.r),
                  ),
                  color: AppColors.appBackgroundColor,
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  // physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        Pinput(
                          controller: loginController.otpController,
                          length: 4,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            loginController.otpError.value = '';
                          },
                          // onCompleted: (value) {
                          //   loginController.verifyOtp();
                          // },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          defaultPinTheme: PinTheme(
                            height: 60.h,
                            width: 60.w,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue1,
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
                        ),

                        Obx(() => loginController.otpError.value.isNotEmpty
                            ? Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: CommonText(
                            text: loginController.otpError.value,
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                        )
                            : const SizedBox(height: 20)),
                        // ==========================================================

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue1,
                                ),
                                text: AppString.resendCodeIn),
                            SizedBox(width: 6.w),
                            Obx(() {
                              int minutes = loginController.secondsRemaining.value ~/ 60;
                              int seconds = loginController.secondsRemaining.value % 60;

                              return CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.yellow,
                                ),
                                text: "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Obx(() => CommonButton(
                          onTap: () => loginController.verifyOtp(),
                          text: loginController.isLoading.value
                              ? "Verifying..."
                              : AppString.verifyCode,
                        )),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue1,
                                ),
                                text: AppString.donTReceive),
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () {
                                if (loginController.enableResend.value) {
                                  loginController.resendOtp();
                                }
                              },
                              child: Obx(() => CommonText(
                                text: AppString.resendCode,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: loginController.enableResend.value
                                    ? AppColors.yellow
                                    : Colors.grey,
                              )),
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