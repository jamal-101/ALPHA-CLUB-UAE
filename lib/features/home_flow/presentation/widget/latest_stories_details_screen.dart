// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:alpha_club/core/utils/app_image/app_image.dart';
// import 'package:alpha_club/core/utils/app_string/app_string.dart';
// import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/service/api/api_enpoint.dart';
//
// class LatestStoriesDetailsScreen extends StatelessWidget {
//   final String storyId;
//    LatestStoriesDetailsScreen({super.key, required this.storyId});
//
//   final HomeController homeController = Get.put(HomeController());
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       homeController.fetchStoryDetails(storyId);
//     });
//
//     return Scaffold(
//       body: Obx(() {
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 50.h),
//                 Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16.r),
//                       child: Image.network(
//                         "${ApiEndPoint.imageBaseUrl}${homeController.singleStoryDetails['image'] ?? ""}",
//                         height: 219.h,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned(
//                       top: 12.h,
//                       left: 12.w,
//                       child: GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           padding: EdgeInsets.all(4.w),
//                           decoration: BoxDecoration(
//                             color: AppColors.gold50,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.arrow_back_sharp,
//                             size: 22.sp,
//                             color: AppColors.blue1,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),
//                 Row(
//                   children: [
//                     Container(
//                       height: 30.h,
//                       width: 30.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [AppColors.blueLiner1, AppColors.blueLiner2],
//                         ),
//                       ),
//                       child: Center(
//                         child: CommonText(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.borderColor,
//                           text: (homeController.singleStoryDetails['club']?['name'] ?? "A")[0],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10.w),
//                     Text(
//                       homeController.singleStoryDetails['club']?['name'] ?? "Alpha Club",
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontFamily: 'SFPro',
//                         color: AppColors.blue1,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 Row(
//                   children: [
//                     Image.asset(
//                         AssetPath.locationIcon, height: 20.h, width: 20.w),
//                     SizedBox(width: 5.w),
//                     CommonText(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.blue1,
//                       text: AppString.sponsorLocation,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//                 Divider(
//                   height: 1,
//                   thickness: 0.9,
//                   color: AppColors.tabSelectedBorderColor,
//                 ),
//                 SizedBox(height: 16.h),
//                 CommonText(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18,
//                   color: AppColors.blue1,
//                   text: AppString.description,
//                 ),
//                 SizedBox(height: 16.h),
//                 CommonText(
//                   textAlign: TextAlign.start,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 16,
//                   color: AppColors.blue1,
//                   text: AppString.landingAutoMotive,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
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

import '../../../../core/global/commont_text.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../controller/home_controller.dart';

class LatestStoriesDetailsScreen extends StatelessWidget {
  final String storyId;
  LatestStoriesDetailsScreen({super.key, required this.storyId});


  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    // স্ক্রিনটি ওপেন হওয়ার সাথে সাথে ডাটা কল করার জন্য:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchStoryDetails(storyId);
    });

    return Scaffold(
      body: Obx(() {
        // লোডিং চেক করা (HomeController এ isLoading ব্যবহার করে)
        if (homeController.isLoading.value && homeController.singleStoryDetails.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                // ইমেজ সেকশন
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        "${ApiEndPoint.imageBaseUrl}${homeController.singleStoryDetails['image'] ?? ""}",
                        height: 219.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                    Positioned(
                      top: 12.h, left: 12.w,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(color: AppColors.gold50, shape: BoxShape.circle),
                          child: Icon(Icons.arrow_back_sharp, size: 22.sp, color: AppColors.blue1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // ক্লাব ইনফো
                Row(
                  children: [
                    Container(
                      height: 30.h, width: 30.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppColors.blueLiner1, AppColors.blueLiner2]),
                      ),
                      child: Center(
                        child: CommonText(
                          fontSize: 18, fontWeight: FontWeight.w500,
                          color: AppColors.borderColor,
                          text: (homeController.singleStoryDetails['club']?['name'] ?? "A")[0],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      homeController.singleStoryDetails['club']?['name'] ?? "Alpha Club",
                      style: TextStyle(fontSize: 20.sp, color: AppColors.blue1, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // লোকেশন
                Row(
                  children: [
                    Image.asset(AssetPath.locationIcon, height: 20.h, width: 20.w),
                    SizedBox(width: 5.w),
                    CommonText(
                      fontSize: 14, fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      text: homeController.singleStoryDetails['club']?['location'] ?? "Location not available",
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(height: 1, thickness: 0.9, color: AppColors.tabSelectedBorderColor),
                SizedBox(height: 16.h),
                CommonText(fontWeight: FontWeight.w500, fontSize: 18, color: AppColors.blue1, text: "Description"),
                SizedBox(height: 16.h),
                CommonText(
                  maxLines: 1000,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.blue1,
                  text: (homeController.singleStoryDetails['description'] ?? "")
                      .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ""),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}