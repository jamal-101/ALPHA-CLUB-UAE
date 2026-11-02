//
//
//
// import 'package:alpha_club/features/clubs/presentation/screen/club_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import '../../../../core/global/commont_text.dart';
// import '../../../../core/service/api/api_enpoint.dart';
// import '../../../../core/utils/app_color/app_color.dart';
// import '../../controller/club_controller.dart';
//
// class DiscoverClub extends StatelessWidget {
//   DiscoverClub({super.key});
//
//   final ClubController clubController = Get.put(ClubController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       // if (clubController.isLoading.value) {
//       //   return const Center(child: CircularProgressIndicator());
//       // }
//
//       return RefreshIndicator(
//         color: Color(0xFF233A66),
//         backgroundColor: AppColors.appBackgroundColor,
//         onRefresh: () async {
//           await clubController.fetchClubs();
//         },
//         child: GridView.builder(
//           physics: const AlwaysScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: clubController.clubList.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12.w,
//             mainAxisSpacing: 12.h,
//             childAspectRatio: 0.80,
//           ),
//           itemBuilder: (context, index) {
//             final item = clubController.clubList[index];
//             final String clubId = item['_id'] ?? "";
//             return GestureDetector(
//               onTap: () {
//                 Get.to(() => ClubDetailsScreen(clubId: clubId));
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF333333).withValues(alpha: 0.04),
//                       blurRadius: 1,
//                       offset: const Offset(0, 0),
//                       spreadRadius: 1,
//                     ),
//                     BoxShadow(
//                       color: const Color(0xFF8F8F8F).withValues(alpha: 0.20),
//                       blurRadius: 3,
//                       offset: const Offset(0, 1),
//                       spreadRadius: 1,
//                     ),
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16.r),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8.r),
//                         child: Image.network(
//                           "${ApiEndPoint.imageBaseUrl}${item["image"] ?? ""}",
//                           height: 144.h,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 115.h,
//                               width: double.infinity,
//                               color: AppColors.otpBorderColor,
//                               child: Icon(
//                                 Icons.image_not_supported_outlined,
//                                 size: 40.sp,
//                                 color: AppColors.blue1.withValues(alpha: 0.3),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(4.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CommonText(
//                             style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: AppColors.blue1,
//                                 fontFamily: 'SFPro'),
//                             textAlign: TextAlign.start,
//                             text: item["name"] ?? "",
//                           ),
//                           SizedBox(height: 4.h),
//                           CommonText(
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14.sp,
//                               color: AppColors.blueBase,
//                             ),
//                             textAlign: TextAlign.start,
//                             text: "${item["limitOfMember"] ?? 0} Memberships",
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     });
//   }
// }

import 'package:alpha_club/features/clubs/presentation/screen/club_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // 🟢 Shimmer package
import '../../../../core/global/commont_text.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../controller/club_controller.dart';

class DiscoverClub extends StatelessWidget {
  DiscoverClub({super.key});

  final ClubController clubController = Get.find<ClubController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 🟢 প্রথমবার লোড হওয়ার সময় শিমার দেখাবে
      if (clubController.isLoading.value && clubController.clubList.isEmpty) {
        return _buildClubShimmerLoader();
      }

      if (clubController.clubList.isEmpty) {
        return const Center(
          child: Text("No clubs available"),
        );
      }

      return RefreshIndicator(
        color: const Color(0xFF233A66),
        backgroundColor: AppColors.appBackgroundColor,
        onRefresh: () async {
          await clubController.fetchClubs(isRefresh: true);
        },
        child: GridView.builder(
          controller: clubController.scrollController, // 🟢 Pagination Scroll Controller
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          // আরও ডাটা ফেচ হওয়ার সময় নিচে ১টি এক্সট্রা আইটেম (লোডিং ইন্ডিকেটর) দেখাবে
          itemCount: clubController.clubList.length +
              (clubController.isMoreLoading.value ? 1 : 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.80,
          ),
          itemBuilder: (context, index) {
            // লিস্টের শেষ প্রান্তে প্রোগ্রেস ইন্ডিকেটর
            if (index == clubController.clubList.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

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
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 144.h,
                              width: double.infinity,
                              color: AppColors.otpBorderColor,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 40.sp,
                                color: AppColors.blue1.withValues(alpha: 0.3),
                              ),
                            );
                          },
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
                              fontFamily: 'SFPro',
                            ),
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
        ),
      );
    });
  }

  // 🟢 Shimmer Loader Widget
  Widget _buildClubShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.80,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          );
        },
      ),
    );
  }
}