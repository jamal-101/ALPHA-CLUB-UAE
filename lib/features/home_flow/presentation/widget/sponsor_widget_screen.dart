//
//
// import 'package:alpha_club/features/home_flow/presentation/screen/our_sponsor_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../core/service/api/api_enpoint.dart';
// import '../../../../core/utils/app_color/app_color.dart';
// import '../../../notification_flow/controller/notification_controller.dart';
// import '../../../profile_flow/controller/profile_controller.dart';
// import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';
// import '../../controller/home_controller.dart';
//
// class SponsorWidgetScreen extends StatelessWidget {
//   const SponsorWidgetScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController homeController = Get.find<HomeController>();
//     final NotificationController notificationController = Get.put(
//       NotificationController(),
//     );
//     final ProfileController profileController = Get.put(ProfileController());
//
//     return Obx(
//       () {
//         return RefreshIndicator(
//           color: Color(0xFF233A66),
//           backgroundColor: AppColors.appBackgroundColor,
//           onRefresh: () async {
//             await homeController.fetchSponsors(isLoadMore: false);
//             await notificationController.getNotificationCount();
//             await profileController.fetchFamilyProfile();
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: AlwaysScrollableScrollPhysics(),
//               itemCount: homeController.sponsors.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12.w,
//                 mainAxisSpacing: 12.h,
//                 childAspectRatio: 1.1,
//               ),
//               itemBuilder: (context, index) {
//                 final item = homeController.sponsors[index];
//                 return GestureDetector(
//                   onTap: () {
//                     homeController.fetchSponsorDetails(item['_id']);
//                     Get.to(OurSponsorScreen());
//                   },
//                   child: CustomBrandCard(
//                     imagePath:
//                         "${ApiEndPoint.imageBaseUrl}${item['logo'].startsWith('/') ? '' : '/'}${item['logo']}",
//                     title: item['title'] ?? "",
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//       // ),
//     );
//   }
// }

import 'package:alpha_club/features/home_flow/presentation/screen/our_sponsor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../notification_flow/controller/notification_controller.dart';
import '../../../profile_flow/controller/profile_controller.dart';
import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';
import '../../controller/home_controller.dart';

class SponsorWidgetScreen extends StatelessWidget {
  SponsorWidgetScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final NotificationController notificationController = Get.put(
    NotificationController(),
  );
  final ProfileController profileController = Get.put(ProfileController());

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 150) {
        if (homeController.hasMoreData && !homeController.isMoreLoading.value) {
          homeController.fetchSponsors(isLoadMore: true);
        }
      }
    });

    return Obx(() {

      if (homeController.isSponsorLoading.value &&
          homeController.sponsors.isEmpty) {
        return _buildSponsorShimmerLoader();
      }

      if (homeController.sponsors.isEmpty) {
        return const Center(
          child: Text("No sponsors available"),
        );
      }

      return RefreshIndicator(
        color: const Color(0xFF233A66),
        backgroundColor: AppColors.appBackgroundColor,
        onRefresh: () async {
          await homeController.fetchSponsors(isLoadMore: false);
          await notificationController.getNotificationCount();
          await profileController.fetchFamilyProfile();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GridView.builder(
            controller: _scrollController,
            shrinkWrap: false,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: homeController.sponsors.length +
                (homeController.isMoreLoading.value ? 1 : 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              if (index == homeController.sponsors.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }

              final item = homeController.sponsors[index];
              return GestureDetector(
                onTap: () {
                  homeController.fetchSponsorDetails(item['_id']);
                  Get.to(() => OurSponsorScreen());
                },
                child: CustomBrandCard(
                  imagePath:
                  "${ApiEndPoint.imageBaseUrl}${item['logo'].startsWith('/') ? '' : '/'}${item['logo']}",
                  title: item['title'] ?? "",
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildSponsorShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GridView.builder(
          itemCount: 6,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            );
          },
        ),
      ),
    );
  }
}
