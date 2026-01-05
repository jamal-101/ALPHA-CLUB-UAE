// import 'package:alpha_club/core/route/app_route.dart';
// import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../core/utils/app_image/app_image.dart';
// import '../../../../core/utils/app_string/app_string.dart';
// import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';
//
// class SponsorWidgetScreen extends StatelessWidget {
//       SponsorWidgetScreen({super.key});
//
//
//   final HomeController homeController = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 20,right: 20),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: (){
//                   Get.toNamed(AppRoute.ourSponsorScreen);
//                 },
//                 child: CustomBrandCard(
//                   imagePath: AssetPath.autoMillennium,
//                   title: AppString.autoMillennium,
//                 ),
//               ),
//               CustomBrandCard(
//                 imagePath: AssetPath.alImage,
//                 title: AppString.autoMillennium,
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomBrandCard(
//                 imagePath: AssetPath.autoMillennium,
//                 title: AppString.autoMillennium,
//               ),
//               CustomBrandCard(
//                 imagePath: AssetPath.alImage,
//                 title: AppString.autoMillennium,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/route/app_route.dart';
import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';

class SponsorWidgetScreen extends StatelessWidget {
  const SponsorWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(() {
        return GridView.builder(
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
                Get.toNamed(AppRoute.ourSponsorScreen);
              },
              child: CustomBrandCard(
                imagePath: "${ApiEndPoint.imageBaseUrl}${item['logo'].startsWith('/') ? '' : '/'}${item['logo']}",
                title: item['title'] ?? "No Title",
              )
            );
          },
        );
      }),
    );
  }
}