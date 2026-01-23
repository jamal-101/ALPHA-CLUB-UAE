import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/custom_phone_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final RxBool isAppLied = false.obs;

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
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
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
              Image.asset(AssetPath.splashImage, height: 130, width: 225),
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
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 85.h),
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro',
                          ),
                          text: AppString.contactNumber,
                        ),
                        SizedBox(height: 12.h),
                        CustomPhoneField(
                          fillColor: AppColors.fillColor,
                          hintText: "09 -1897243189",
                          onNumberChanged: (phone) {
                            debugPrint(
                              "Full Number: ${phone.completeNumber}",
                            );
                            controller.phoneNumber.value =
                                phone.completeNumber;
                          },
                        ),
                        SizedBox(height: 24.h),
                        CommonText(
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro',
                          ),
                          text: AppString.newPassword,
                        ),
                        SizedBox(height: 12.h),
                        CommonTextField(
                          isPassword: true,
                          hintText: '********',
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.singInVerify);
                              },
                              child: CommonText(
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue1,
                                  fontFamily: 'SFPro',
                                ),
                                text: AppString.forgetPass,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Obx(
                          () => CommonButton(
                            onTap: controller.isLoading.value
                                ? () {}
                                : () => controller.login(),
                            text: controller.isLoading.value
                                ? 'Loading...'
                                : AppString.sinIn,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: AppColors.blue1,
                              ),
                              text: AppString.becomeAnd,
                            ),
                            SizedBox(width: 10.w),
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.linearGradient1,
                                      AppColors.linearGradient2,
                                    ],
                                  ).createShader(
                                    Rect.fromLTWH(
                                      0,
                                      0,
                                      bounds.width,
                                      bounds.height,
                                    ),
                                  ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.memberFormScreen);
                                },
                                child: Text(
                                  AppString.applyHere,
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFDFBB0B),
                                  ),
                                ),
                              ),
                            ),
                          ],

                        ),
                        SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 40.h),
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



// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final LoginController controller = Get.put(LoginController());
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AssetPath.splashBackground),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               SizedBox(height: 60.h),
//               Image.asset(AssetPath.splashImage, height: 130, width: 225),
//               CommonText(
//                 text: AppString.sinIn,
//                 color: AppColors.whiteFoundation,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 24.sp,
//               ),
//               SizedBox(height: 10.h),
//               CommonText(
//                 textAlign: TextAlign.center,
//                 text: AppString.enterYourMobile,
//                 color: AppColors.whiteFoundation,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 18.sp,
//               ),
//               CommonText(
//                 textAlign: TextAlign.center,
//                 text: AppString.toAccess,
//                 color: AppColors.whiteFoundation,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 18.sp,
//               ),
//               SizedBox(height: 34.h),
//
//               // ওটিপি স্ক্রিনের মতো এখানেও কন্টেইনারে হাইট দেওয়া হয়েছে
//               Container(
//                 // আপনি ওটিপি স্ক্রিনে ০.৬ ব্যবহার করেছেন, এখানে কন্টেন্ট বেশি বলে ০.৭ দিতে পারেন
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(45.r),
//                     topRight: Radius.circular(45.r),
//                   ),
//                   color: AppColors.appBackgroundColor,
//                 ),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 60.h),
//                         CommonText(
//                           text: AppString.contactNumber,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.blue1,
//                             fontFamily: 'SFPro',
//                           ),
//                         ),
//                         SizedBox(height: 12.h),
//                         CustomPhoneField(
//                           hintText: "09 -1897243189",
//                           onNumberChanged: (phone) {
//                             controller.phoneNumber.value = phone.completeNumber;
//                           },
//                         ),
//                         SizedBox(height: 24.h),
//                         CommonText(
//                           text: AppString.newPassword,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.blue1,
//                             fontFamily: 'SFPro',
//                           ),
//                         ),
//                         SizedBox(height: 12.h),
//                         CommonTextField(
//                           isPassword: true,
//                           hintText: '********',
//                           onChanged: (value) => controller.password.value = value,
//                         ),
//                         SizedBox(height: 20.h),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: GestureDetector(
//                             onTap: () => Get.toNamed(AppRoute.singInVerify),
//                             child: CommonText(
//                               text: AppString.forgetPass,
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.blue1,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30.h),
//                         Obx(() => CommonButton(
//                           onTap: controller.isLoading.value ? () {} : () => controller.login(),
//                           text: controller.isLoading.value ? 'Loading...' : AppString.sinIn,
//                         )),
//                         SizedBox(height: 40.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CommonText(text: AppString.becomeAnd, fontSize: 14.sp),
//                             SizedBox(width: 10.w),
//                             GestureDetector(
//                               onTap: () => Get.toNamed(AppRoute.memberFormScreen),
//                               child: Text(
//                                 AppString.applyHere,
//                                 style: TextStyle(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFFDFBB0B),
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         // কিবোর্ড আসলে নিচের কন্টেন্ট যেন দেখা যায়
//                         SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 40.h),
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


