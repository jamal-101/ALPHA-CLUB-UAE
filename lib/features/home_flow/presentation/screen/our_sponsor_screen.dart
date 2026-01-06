import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../../core/service/api/api_enpoint.dart';


class OurSponsorScreen extends StatelessWidget {
     OurSponsorScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        final sponsor = homeController.singleSponsorDetails;

        if (homeController.isLoading.value) {
          return Container(
            height: 219.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new_rounded, size: 18,
                      color: AppColors.blue1,)),
                SizedBox(height: 24.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    "${ApiEndPoint.imageBaseUrl}${sponsor['image'] ?? ""}",
                    height: 219.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.h),
                CommonText(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue1,
                  text: sponsor['title'] ?? "",
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Image.asset(
                        AssetPath.locationIcon, height: 20.h, width: 20.w),
                    SizedBox(width: 5.w),
                    CommonText(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      text: homeController.singleSponsorDetails['location'] ?? "No Location Found",
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(
                  height: 1,
                  thickness: 0.9,
                  color: AppColors.tabSelectedBorderColor,
                ),
                SizedBox(height: 16.h),
                CommonText(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.blue1,
                  text: AppString.description,
                ),
                SizedBox(height: 16.h),
                HtmlWidget(
                  sponsor['description'] ?? "",
                  textStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueBase,
                    fontFamily: 'SFPro',
                  ),
                  renderMode: RenderMode.column,
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
        }
      ),
    );
  }
}



// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:alpha_club/core/utils/app_image/app_image.dart';
// import 'package:alpha_club/core/utils/app_string/app_string.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
//
// class OurSponsorScreen extends StatelessWidget {
//   const OurSponsorScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20,right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 50.h),
//             GestureDetector(
//                 onTap: (){
//                   Get.back();
//                 },
//                 child: Icon(Icons.arrow_back_ios_new_rounded,size: 18,color: AppColors.blue1,)),
//             SizedBox(height: 24.h),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16.r),
//               child: Image.asset(
//                 AssetPath.sponsorImage,
//                 height: 219.h,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 20.h),
//             CommonText(
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.blue1,
//                 text: AppString.autoMillennium1
//             ),
//             SizedBox(height: 8.h),
//             CommonText(
//                 style: TextStyle(
//                     color: AppColors.blue1,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     fontFamily: 'SFPro'
//                 ),
//                 text: AppString.autoGroup),
//             SizedBox(height: 12.h),
//             Row(
//               children: [
//                 Image.asset(AssetPath.locationIcon,height: 20.h,width: 20.w),
//                 SizedBox(width: 5.w),
//                 CommonText(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.blue1,
//                   text: AppString.sponsorLocation,
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             Divider(
//               height: 1,
//               thickness: 0.9,
//               color: AppColors.tabSelectedBorderColor,
//             ),
//             SizedBox(height: 16.h),
//             CommonText(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 18,
//                 color: AppColors.blue1,
//                 text: AppString.description),
//             SizedBox(height: 16.h),
//             CommonText(
//                 textAlign: TextAlign.start,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.blueBase,
//                 text: AppString.landingAutoMotive),
//             SizedBox(height: 16.h),
//             Row(
//               children: [
//                 Image.asset(AssetPath.checkIcon,height: 12.h,width: 12.w,),
//                 SizedBox(width: 6.w),
//                 CommonText(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.blue1,
//                     text: AppString.choiceOf
//                 )
//               ],
//             ),
//             SizedBox(height: 5.h),
//             Row(
//               children: [
//                 Image.asset(AssetPath.checkIcon,height: 12.h,width: 12.w,),
//                 SizedBox(width: 6.w),
//                 CommonText(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.blue1,
//                     text: AppString.validMon
//                 )
//               ],
//             ),
//             SizedBox(height: 5.h),
//             Row(
//               children: [
//                 Image.asset(AssetPath.checkIcon,height: 12.h,width: 12.w,),
//                 SizedBox(width: 6.w),
//                 CommonText(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.blue1,
//                     text: AppString.reservationRec
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
