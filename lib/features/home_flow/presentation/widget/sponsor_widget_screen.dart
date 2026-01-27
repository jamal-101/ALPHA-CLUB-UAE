// import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
// import 'package:alpha_club/features/home_flow/presentation/screen/our_sponsor_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../core/service/api/api_enpoint.dart';
// import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';
//
// class SponsorWidgetScreen extends StatelessWidget {
//   const SponsorWidgetScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController homeController = Get.put(HomeController());
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Obx(() {
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: homeController.sponsors.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12.w,
//             mainAxisSpacing: 12.h,
//             childAspectRatio: 1.1,
//           ),
//           itemBuilder: (context, index) {
//             final item = homeController.sponsors[index];
//             return GestureDetector(
//               onTap: () {
//                 homeController.fetchSponsorDetails(item['_id']);
//                 Get.to(OurSponsorScreen());
//               },
//               child: CustomBrandCard(
//                 imagePath: "${ApiEndPoint.imageBaseUrl}${item['logo'].startsWith('/') ? '' : '/'}${item['logo']}",
//                 title: item['title'] ?? "",
//               )
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:alpha_club/features/home_flow/presentation/screen/our_sponsor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../notification_flow/controller/notification_controller.dart';
import '../../../profile_flow/controller/profile_controller.dart';
import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';
import '../../controller/home_controller.dart';

class SponsorWidgetScreen extends StatelessWidget {
  const SponsorWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final NotificationController notificationController = Get.put(NotificationController());
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      body : Obx(() {
        // if (homeController.isSponsorLoading.value && homeController.sponsors.isEmpty) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        return RefreshIndicator(
          color: Color(0xFF233A66),
          backgroundColor: AppColors.appBackgroundColor,
          onRefresh: () async {
            await homeController.fetchSponsors(isLoadMore: false);
            await notificationController.getNotificationCount();
            await profileController.fetchFamilyProfile();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeController.sponsors.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.1,
                    ),
                    itemBuilder: (context, index) {
                      final item = homeController.sponsors[index];
                      return GestureDetector(
                        onTap: () {
                          homeController.fetchSponsorDetails(item['_id']);
                          Get.to(OurSponsorScreen());
                        },
                        child: CustomBrandCard(
                          imagePath: "${ApiEndPoint.imageBaseUrl}${item['logo'].startsWith('/') ? '' : '/'}${item['logo']}",
                          title: item['title'] ?? "",
                        ),
                      );
                    },
                  ),
                  if (homeController.isMoreLoading.value)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}