// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import '../../../../../../../core/service/api/api_enpoint.dart';
// import '../../../../../../../core/utils/app_color/app_color.dart';
//
//
// class AlphaFamilyWidget extends StatelessWidget {
//      AlphaFamilyWidget({super.key});
//
//   final ProfileController profileController = Get.put(ProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//
//     final alphaFamilyData = profileController.alphaFamilyLanList;
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.appBackgroundColor,
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.goldColor1.withValues(alpha: 0.2),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.network(
//                         "${ApiEndPoint.imageBaseUrl}${alphaFamilyData['logo'] ?? ""}",
//                         height: 25.h,
//                         width: 25.w,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CommonText(
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontFamily: 'SFPro',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         color: AppColors.blue1,
//                         text: alphaFamilyData['title'] ?? "No Title",
//                       ),
//                       CommonText(
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontFamily: 'SFPro',
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                         color: AppColors.blueBase,
//                         text: alphaFamilyData['description'] ?? "No Description",
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12.h),
//             CommonText(
//               maxLines: 4,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                 fontFamily: 'SFPro',
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.blueBase,
//               ),
//               text: alphaFamilyData['subDescription'] ?? "No Sub-description",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';

class AlphaFamilyWidget extends StatelessWidget {
  AlphaFamilyWidget({super.key});

  // Get.find ব্যবহার করা হয়েছে যাতে ডুপ্লিকেট কন্ট্রোলার তৈরি না হয়
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // ১. লোডিং স্টেট হ্যান্ডেল করা
      if (profileController.isLoading.value && profileController.combinedPlans.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // ২. ড্রপডাউনে সিলেক্ট করা প্ল্যান অনুযায়ী ডাটা ফিল্টার করা
      final data = profileController.combinedPlans.firstWhere(
            (plan) => plan['membershipType'] == profileController.selectedMemberTypeCode.value,
        orElse: () => null,
      );

      if (data == null) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.appBackgroundColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // এলাইনমেন্ট ঠিক করা হয়েছে
                children: [
                  // লোগো সেকশন
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldColor1.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        "${ApiEndPoint.imageBaseUrl}${data['logo'] ?? ""}",
                        height: 25.h,
                        width: 25.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.star, color: AppColors.goldColor1, size: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontSize: 16.sp, // ScreenUtil ব্যবহার করা হয়েছে
                            fontWeight: FontWeight.w600,
                          ),
                          color: AppColors.blue1,
                          text: data['title'] ?? "No Title",
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppColors.blueBase,
                          text: data['description'] ?? "No Description",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (data['subDescription'] != null) ...[
                SizedBox(height: 12.h),
                CommonText(
                  maxLines: 4,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueBase,
                  ),
                  text: data['subDescription'] ?? "",
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}