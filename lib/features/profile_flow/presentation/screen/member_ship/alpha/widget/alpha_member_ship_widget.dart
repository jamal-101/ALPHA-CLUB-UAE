// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import '../../../../../../../core/global/commont_text.dart';
// import '../../../../../../../core/service/api/api_enpoint.dart';
// import '../../../../../../../core/utils/app_color/app_color.dart';
// import '../../../../../controller/profile_controller.dart';
//
// class AlphaMemberShipWidget extends StatelessWidget {
//   const AlphaMemberShipWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final ProfileController profileController = Get.put(ProfileController());
//
//     return Obx(() {
//       if (profileController.alphaPlan.isEmpty) return Center(child: CircularProgressIndicator());
//
//
//       final data = profileController.alphaPlanList;
//       return Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(bottom: 16.h),
//         decoration: BoxDecoration(
//           color: AppColors.appBackgroundColor,
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(12.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.blue1.withValues(alpha: 0.2),
//                     ),
//                     child: Image.network(
//                       "${ApiEndPoint.imageBaseUrl}${data['logo'] ?? ""}",
//                       height: 25.h,
//                       width: 25.w,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CommonText(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.blue1,
//                           text: data['title'] ?? "No Title",
//                         ),
//                         CommonText(
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.blueBase,
//                           text: data['description'] ?? "No Description",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12.h),
//               CommonText(
//                 textAlign: TextAlign.start,
//                 fontSize: 13.sp,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.blueBase,
//                 text: data['subDescription'] ?? "No Sub-description",
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../core/global/commont_text.dart';
import '../../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../controller/profile_controller.dart';

class AlphaMemberShipWidget extends StatelessWidget {
  const AlphaMemberShipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Obx(() {
      if (profileController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final data = profileController.combinedPlans.firstWhere(
            (plan) => plan['membershipType'] == profileController.selectedMemberTypeCode.value,
        orElse: () => null,
      );

      if (data == null) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue1.withOpacity(0.1),
                    ),
                    child: Image.network(
                      "${ApiEndPoint.imageBaseUrl}${data['logo'] ?? ""}",
                      height: 25.h,
                      width: 25.w,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.workspace_premium, color: AppColors.blue1, size: 20.sp),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue1,
                          text: data['title'] ?? "No Title",
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
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
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blueBase,
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
