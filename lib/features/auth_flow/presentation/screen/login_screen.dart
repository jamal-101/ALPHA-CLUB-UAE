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
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 30.h),
                  // GestureDetector(
                  //       onTap: () {
                  //         isAppLied.value = true;
                  //         Get.toNamed(AppRoute.homeScreen);
                  //       },
                  //       child: Container(
                  //         height: 27.h,
                  //         width: 57.w,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(25.r),
                  //           border: Border.all(
                  //             width: 1.w,
                  //             color: AppColors.skipColor,
                  //           ),
                  //         ),
                  //         child: Center(
                  //           child: CommonText(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 14,
                  //             color: AppColors.skipColor,
                  //             text: "Skip",
                  //           ),
                  //         ),
                  //       ),
                  //     // );
                  //   // }
                  //   ),
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
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                              fontFamily: 'SFPro',
                            ),
                            text: AppString.contactNumber,
                          ),
                          SizedBox(height: 12.h),
                          CustomPhoneField(
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
                              fontSize: 14.sp,
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
                                    fontSize: 14.sp,
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
                                  fontSize: 14.sp,
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
                                      fontSize: 14.sp,
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
                        ],
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


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../../../../core/global/common_button.dart';
// import '../../../../core/global/common_text_field.dart';
// import '../../../../core/global/commont_text.dart';
// import '../../../../core/global/custom_phone_field.dart';
// import '../../../../core/route/app_route.dart';
// import '../../../../core/utils/app_color/app_color.dart';
// import '../../../../core/utils/app_image/app_image.dart';
// import '../../../../core/utils/app_string/app_string.dart';
// import '../../controller/login_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final LoginController controller = Get.put(LoginController());
//     return Scaffold(
//       // ১. কিবোর্ড ওপেন হলে বডি ছোট হবে যেন স্ক্রল করা যায়
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
//         // ২. পুরো স্ক্রিনকে স্ক্রল করার জন্য SingleChildScrollView ব্যবহার করা হয়েছে
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               SizedBox(height: 60.h),
//               // লোগো এবং উপরের টেক্সট
//               Image.asset(AssetPath.splashImage, height: 130.h, width: 225.w),
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
//               // ৩. সাদা কন্টেইনার (এখানে Expanded সরিয়ে ফেলা হয়েছে)
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(45.r),
//                     topRight: Radius.circular(45.r),
//                   ),
//                   color: AppColors.appBackgroundColor,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: 20.w,
//                     right: 20.w,
//                     top: 50.h,
//                     // কিবোর্ড যেন শেষ বাটনকে ঢেকে না দেয়
//                     bottom: MediaQuery.of(context).viewInsets.bottom + 40.h,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CommonText(
//                         text: AppString.contactNumber,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.blue1,
//                         ),
//                       ),
//                       SizedBox(height: 12.h),
//                       CustomPhoneField(
//                         hintText: "09 -1897243189",
//                         onNumberChanged: (phone) {
//                           controller.phoneNumber.value = phone.completeNumber;
//                         },
//                       ),
//                       SizedBox(height: 24.h),
//                       CommonText(
//                         text: AppString.newPassword,
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.blue1,
//                         ),
//                       ),
//                       SizedBox(height: 12.h),
//                       CommonTextField(
//                         isPassword: true,
//                         hintText: '********',
//                         onChanged: (value) => controller.password.value = value,
//                       ),
//                       SizedBox(height: 20.h),
//                       // ফরগেট পাসওয়ার্ড
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: GestureDetector(
//                           onTap: () => Get.toNamed(AppRoute.singInVerify),
//                           child: CommonText(
//                             text: AppString.forgetPass,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.blue1,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 30.h),
//                       // লগইন বাটন
//                       Obx(() => CommonButton(
//                         onTap: controller.isLoading.value ? () {} : () => controller.login(),
//                         text: controller.isLoading.value ? 'Loading...' : AppString.sinIn,
//                       )),
//                       SizedBox(height: 40.h),
//                       // মেম্বারশিপ লিংক
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CommonText(text: AppString.becomeAnd, fontSize: 14.sp),
//                           SizedBox(width: 8.w),
//                           GestureDetector(
//                             onTap: () => Get.toNamed(AppRoute.memberFormScreen),
//                             child: Text(
//                               AppString.applyHere,
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w600,
//                                 decoration: TextDecoration.underline,
//                                 color: const Color(0xFFDFBB0B),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20.h), // বাড়তি স্পেস
//                     ],
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