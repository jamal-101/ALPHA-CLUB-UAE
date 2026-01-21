// import 'package:alpha_club/core/global/common_button.dart';
// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:alpha_club/core/utils/app_image/app_image.dart';
// import 'package:alpha_club/core/utils/app_string/app_string.dart';
// import 'package:alpha_club/features/auth_flow/controller/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pinput/flutter_pinput.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
//
// class SingInOtp extends StatelessWidget {
//       SingInOtp({super.key});
//
//   final LoginController loginController = Get.put(LoginController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AssetPath.splashBackground),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(height: 90.h),
//               Image.asset(AssetPath.splashImage, height: 130, width: 240),
//               SizedBox(height: 70.h),
//               CommonText(
//                 style: TextStyle(
//                   fontFamily: 'SFPro',
//                   color: AppColors.whiteFoundation,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 20.sp,
//                 ),
//                 text: AppString.enderDigit,
//               ),
//               SizedBox(height: 10.h),
//               CommonText(
//                 textAlign: TextAlign.center,
//                 text: AppString.enterThemFourDigit,
//                 color: AppColors.whiteFoundation1,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14.sp,
//               ),
//               SizedBox(height: 55.h),
//               Expanded(
//                 child: Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(45.r),
//                       topRight: Radius.circular(45.r),
//                     ),
//                     color: AppColors.appBackgroundColor,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 20,right: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 159.h),
//                         Pinput(
//                           controller: loginController.otpController,
//                           length: 4,
//                           keyboardType: TextInputType.number,
//                           onCompleted: (value) {
//                             loginController.verifyOtp();
//                           },
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           // controller: singUpOtpController.singUpOtp,
//                           // validator: FormValidation.validatePin,
//                           defaultPinTheme: PinTheme(
//                             height: 60.h,
//                             width: 60.w,
//                             margin: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
//                             textStyle: TextStyle(
//                               fontFamily: 'SFPro',
//                               fontSize: 20,
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.blue1,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16.r),
//                               color: AppColors.otpFillColor,
//                               border: Border.all(
//                                 width: 1.w,
//                                 color: AppColors.otpBorderColor,
//                               ),
//                             ),
//                           ),
//                           preFilledWidget: Text(
//                             '-',
//                             style: TextStyle(
//                               fontFamily: 'SFPro',
//                               fontSize: 20,
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.blue1,
//                             ),
//                           ),
//                           // onChanged: (value) {
//                           //   if (value.isNotEmpty) {
//                           //     errorMessage.value = '';
//                           //   }
//                           // },
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CommonText(
//                               style: TextStyle(
//                                 fontFamily: 'SFPro',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.blue1,
//                               ),
//                                 text:AppString.resendCodeIn),
//                             SizedBox(width: 6.w),
//                             CommonText(
//                                 style: TextStyle(
//                                   fontFamily: 'SFPro',
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColors.yellow,
//                                 ),
//                                 text:AppString.second),
//                           ],
//                         ),
//                         SizedBox(height: 60.h),
//                         Obx(() => CommonButton(
//                           onTap: loginController.isLoading.value
//                               ? null
//                               : () => loginController.verifyOtp(),
//                           text: loginController.isLoading.value ? "Verifying..." : AppString.verifyCode,
//                         )),
//                         SizedBox(height: 24.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CommonText(
//                                 style: TextStyle(
//                                   fontFamily: 'SFPro',
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColors.blue1,
//                                 ),
//                                 text:AppString.donTReceive),
//                             SizedBox(width: 15.w),
//                             CommonText(
//                                 text:AppString.resendCode,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: AppColors.yellow,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pinput/flutter_pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/common_button.dart';
import '../../../../core/global/commont_text.dart';
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
          child: Column(
            children: [
              SizedBox(height: 90.h),
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
                fontSize: 14.sp,
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

                        // ================== ১. ভ্যালিডেশন এরর মেসেজ ==================
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
                            // CommonText(
                            //     style: TextStyle(
                            //       fontFamily: 'SFPro',
                            //       fontSize: 18.sp,
                            //       fontWeight: FontWeight.w400,
                            //       color: AppColors.yellow,
                            //     ),
                            //     text: AppString.second),

                            // Obx(() => CommonText(
                            //     style: TextStyle(
                            //       fontFamily: 'SFPro',
                            //       fontSize: 18.sp,
                            //       fontWeight: FontWeight.w400,
                            //       color: AppColors.yellow,
                            //     ),
                            //     text: "00:${loginController.secondsRemaining.value.toString().padLeft(2, '0')}")),
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
                                text: "$minutes:${seconds.toString().padLeft(2, '0')}",
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 40.h),

                        // ================== ২. বাটন আপডেট ==================
                        // Obx(() => CommonButton(
                        //   onTap: () => loginController.verifyOtp(),
                        //   text: loginController.isLoading.value
                        //       ? "Verifying..."
                        //       : AppString.verifyCode,
                        // )),

                        Obx(() => CommonButton(
                          onTap: () => loginController.verifyOtp(),
                          text: loginController.isLoading.value
                              ? "Verifying..."
                              : AppString.verifyCode,
                        )),
                        // CommonButton(onTap: (){
                        //   Get.toNamed(AppRoute.changePasswordScreen);
                        // }, text: "Send Code"),
                        // ==================================================

                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue1,
                                ),
                                text: AppString.donTReceive),
                            SizedBox(width: 15.w),
                            // GestureDetector(
                            //   onTap: () {
                            //     // Resend OTP logic
                            //   },
                            //   child: CommonText(
                            //     text: AppString.resendCode,
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: 14.sp,
                            //     color: AppColors.yellow,
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                if (loginController.enableResend.value) {
                                  loginController.resendOtp();
                                }
                              },
                              child: Obx(() => CommonText(
                                text: AppString.resendCode,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
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