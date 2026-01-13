// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../../core/utils/app_color/app_color.dart';
// import '../../../../../../core/utils/app_image/app_image.dart';
//
// class FamilyListWidget extends StatelessWidget {
//   const FamilyListWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> members = [
//       {"image": AssetPath.memberShipImage, "name": "Sarah Anderson", "relation": "Spouse", "status": "Active"},
//       {"image": AssetPath.memberShipImage, "name": "John doe", "relation": "Son", "status": "Active"},
//     ];
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: const Color(0xFFE2E8F0),
//           width: 1.w,
//         ),
//       ),
//       child: ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: members.length,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           final member = members[index];
//           return Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 4.h),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 36.w,
//                       width: 36.w,
//                       decoration: BoxDecoration(
//                         color: AppColors.blue1.withValues(alpha: 0.4),
//                         shape: BoxShape.circle,
//                       ),
//                       child: ClipOval(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Image.asset(
//                             member["image"]!,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CommonText(
//                             fontSize: 16,
//                               color: AppColors.blue1,
//                               fontWeight: FontWeight.w400,
//                               text: member["name"]!,
//                           ),
//                           CommonText(
//                             fontWeight: FontWeight.w400,
//                               fontSize: 12.sp,
//                               color: AppColors.blueBase,
//                               text: member["relation"]!),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                       decoration: BoxDecoration(
//                         color: AppColors.green1.withValues(alpha: 0.1),
//                         borderRadius: BorderRadius.circular(20.r),
//                       ),
//                       child: CommonText(
//                         fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.green1,
//                           text: member["status"]!)
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../controller/profile_controller.dart';

class FamilyListWidget extends StatelessWidget {
  const FamilyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // কন্ট্রোলার ইনিশিয়ালাইজ করার পর API কল করা
    final ProfileController controller = Get.put(ProfileController());

    // ডাটা যদি আগে থেকে লোড করা না থাকে তবে ফেচ করবে
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.familyList.isEmpty) {
        controller.fetchFamilyProfile();
      }
    });

    return Obx(() {
      // লোডিং অবস্থায় সার্কেল দেখানো
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // যদি লিস্ট খালি থাকে
      if (controller.familyList.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("No family members found"),
          ),
        );
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.familyList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final member = controller.familyList[index];
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.w,
                        backgroundColor: AppColors.blue1.withOpacity(0.1),
                        child: Icon(Icons.person, color: AppColors.blue1, size: 20.w),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              fontSize: 16,
                              color: AppColors.blue1,
                              fontWeight: FontWeight.w400,
                              text: member["name"] ?? "Unknown",
                            ),
                            CommonText(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.blueBase,
                              text: member["relation"]?.toString().capitalizeFirst ?? "",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (index != controller.familyList.length - 1)
                  const Divider(color: Color(0xFFE2E8F0), height: 1),
              ],
            );
          },
        ),
      );
    });
  }
}