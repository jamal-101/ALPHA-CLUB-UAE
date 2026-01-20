// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/core/route/app_route.dart';
// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:alpha_club/core/utils/app_image/app_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
//
// class DiscoverClub extends StatelessWidget {
//   const DiscoverClub({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> eventData = [
//       {
//         "title": "Veo Gym",
//         "desc": "5 Memberships",
//         "image": AssetPath.gymImage
//       },
//       {
//         "title": "Atlantis",
//         "desc": "3 Memberships",
//         "image": AssetPath.gymImage
//       },
//       {
//         "title": "5iron Indoor Golf",
//         "desc": "Available",
//         "image": AssetPath.gymImage
//       },
//     ];
//
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: eventData.length,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12.w,
//         mainAxisSpacing: 12.h,
//         childAspectRatio: 0.80,
//       ),
//       itemBuilder: (context, index) {
//         final item = eventData[index];
//         return GestureDetector(
//           onTap: (){
//             Get.toNamed(AppRoute.clubDetailsScreen);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF333333).withValues(alpha: 0.04),
//                   blurRadius: 1,
//                   offset: const Offset(0, 0),
//                   spreadRadius: 1,
//                 ),
//                 BoxShadow(
//                   color: const Color(0xFF8F8F8F).withValues(alpha: 0.20),
//                   blurRadius: 3,
//                   offset: const Offset(0, 1),
//                   spreadRadius: 1,
//                 ),
//               ],
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16.r),
//               border: Border.all(color: Colors.grey.shade200),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 4,right: 4,top: 4),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.r),
//                     child: Image.asset(
//                       item["image"]!,
//                       height: 144.h,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(4.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CommonText(
//                         style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.blue1,
//                             fontFamily: 'SFPro'
//                         ),
//                         textAlign: TextAlign.start,
//                         text:  item["title"]!,),
//                       SizedBox(height: 4.h),
//                       CommonText(
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 14,
//                           color: AppColors.blueBase,
//                         ),
//                         textAlign: TextAlign.start,
//                         text:  item["desc"]!,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:alpha_club/features/clubs/presentation/screen/club_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../controller/club_controller.dart';

class DiscoverClub extends StatelessWidget {
  DiscoverClub({super.key});

  final ClubController clubController = Get.put(ClubController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (clubController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: clubController.clubList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.80,
        ),
        itemBuilder: (context, index) {
          final item = clubController.clubList[index];
          final String clubId = item['_id'] ?? "";
          return GestureDetector(
            onTap: () {
              Get.to(() => ClubDetailsScreen(clubId: clubId));
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF333333).withValues(alpha: 0.04),
                    blurRadius: 1,
                    offset: const Offset(0, 0),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: const Color(0xFF8F8F8F).withValues(alpha: 0.20),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                    spreadRadius: 1,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        "${ApiEndPoint.imageBaseUrl}${item["image"] ?? ""}",
                        height: 144.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blue1,
                              fontFamily: 'SFPro'),
                          textAlign: TextAlign.start,
                          text: item["name"] ?? "",
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.blueBase,
                          ),
                          textAlign: TextAlign.start,
                          text: "${item["limitOfMember"] ?? 0} Memberships",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}