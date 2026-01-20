// import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import '../../../../../../../core/service/api/api_enpoint.dart';
// import '../../../../../../../core/utils/app_color/app_color.dart';
// import '../../../../../../../core/utils/app_image/app_image.dart';
//
// class AllStanderList extends StatelessWidget {
//  const AllStanderList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final profileController = Get.put(ProfileController());
//
//     return Obx(() {
//       final List features = profileController.alphaFamilyLanList['features'];
//
//       return ListView.builder(
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: features.length,
//         itemBuilder: (context, index) {
//           final item = features[index];
//
//           return Container(
//             margin: EdgeInsets.only(bottom: 12.h),
//             padding: EdgeInsets.all(10.w),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: AppColors.otpBorderColor, width: 1.w),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 48.h,
//                   width: 48.w,
//                   decoration: BoxDecoration(
//                     color: AppColors.goldColor1.withValues(alpha: 0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   padding: EdgeInsets.all(10.w),
//                   child: Image.network(
//                     "${ApiEndPoint.imageBaseUrl}${item['icon'] ?? ""}",
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) =>
//                     const Icon(Icons.star, color: AppColors.goldColor1),
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item['title'] ?? "",
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontFamily: 'SFPro',
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.blue1,
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         item['description'] ?? "",
//                         style: TextStyle(
//                             fontFamily: 'SFPro',
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.blueBase
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Image.asset(
//                   AssetPath.checkIcon,
//                   color: AppColors.green1,
//                   height: 16.h,
//                   width: 16.w,
//                 )
//               ],
//             ),
//           );
//         },
//       );
//     });
//   }
// }



import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../../core/utils/app_image/app_image.dart';

class AllStanderList extends StatelessWidget {
  const AllStanderList({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find ব্যবহার করা হয়েছে যাতে ডুপ্লিকেট কন্ট্রোলার তৈরি না হয়
    final ProfileController profileController = Get.find<ProfileController>();

    return Obx(() {
      // ১. লোডিং স্টেট হ্যান্ডেল করা
      if (profileController.isLoading.value && profileController.combinedPlans.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      // ২. ড্রপডাউনে সিলেক্ট করা প্ল্যান অনুযায়ী ডাটা খুঁজে বের করা
      final selectedPlan = profileController.combinedPlans.firstWhere(
            (plan) => plan['membershipType'] == profileController.selectedMemberTypeCode.value,
        orElse: () => null,
      );

      // ৩. ফিচার লিস্ট বের করা
      final List features = selectedPlan != null ? (selectedPlan['features'] ?? []) : [];

      // যদি কোনো ফিচার না থাকে তবে লিস্টটি দেখাবে না
      if (features.isEmpty) {
        return const SizedBox.shrink();
      }

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final item = features[index];

          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w), // একটু বাড়িয়ে ১২ করা হয়েছে ক্লিন লুকের জন্য
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.otpBorderColor, width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // গোল্ডেন সার্কেল আইকন (Network Image)
                Container(
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.goldColor1.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Image.network(
                    "${ApiEndPoint.imageBaseUrl}${item['icon'] ?? ""}",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.star, color: AppColors.goldColor1),
                  ),
                ),
                SizedBox(width: 12.w),
                // টাইটেল এবং ডেসক্রিপশন
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] ?? "N/A",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item['description'] ?? "",
                        style: TextStyle(
                            fontFamily: 'SFPro',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueBase),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                // গ্রিন চেক আইকন
                Image.asset(
                  AssetPath.checkIcon,
                  color: AppColors.green1,
                  height: 18.h,
                  width: 18.w,
                )
              ],
            ),
          );
        },
      );
    });
  }
}