
import 'package:carousel_slider/carousel_slider.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchStoryDetails(storyId);
    });

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (homeController.isLoading.value && homeController.singleStoryDetails.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final List storyImages = homeController.singleStoryDetails['image'] is List
              ? homeController.singleStoryDetails['image']
              : [homeController.singleStoryDetails['image']];

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              physics : AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Stack(
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(16.r),
                      //   child:
                      //   Image.network(
                      //     "${ApiEndPoint.imageBaseUrl}${homeController.singleStoryDetails['image'] ?? ""}",
                      //     height: 219.h,
                      //     width: double.infinity,
                      //     fit: BoxFit.cover,
                      //     errorBuilder: (context, error, stackTrace) =>
                      //     const Icon(Icons.broken_image, size: 50),
                      //   ),
                      // ),


                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 219.h,
                                viewportFraction: 1.0,
                                autoPlay: storyImages.length > 1,
                                enlargeCenterPage: false,
                                onPageChanged: (slideIndex, reason) {
                                  homeController.detailsSliderIndex.value = slideIndex;
                                },
                              ),
                              items: storyImages.map((imageUrl) {
                                return Image.network(
                                  "${ApiEndPoint.imageBaseUrl}$imageUrl",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 50),
                                );
                              }).toList(),
                            ),
                            if (storyImages.length > 1)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: storyImages.asMap().entries.map((entry) {
                                    return Obx(() => Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: homeController.detailsSliderIndex.value == entry.key
                                            ? AppColors.green1
                                            : Colors.grey.withValues(alpha: 0.3),
                                      ),
                                    ));
                                  }).toList(),
                                ),
                              ),
                          ],
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
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 30.h, width: 30.w,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         gradient: LinearGradient(colors: [AppColors.blueLiner1, AppColors.blueLiner2]),
                  //       ),
                  //       child: Center(
                  //         child: CommonText(
                  //           fontSize: 18, fontWeight: FontWeight.w500,
                  //           color: AppColors.borderColor,
                  //           text: (homeController.singleStoryDetails['club']?['name'] ?? "A")[0],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 10.w),
                  //     Text(
                  //       homeController.singleStoryDetails['club']?['name'] ?? "Alpha Club",
                  //       style: TextStyle(fontSize: 20.sp, color: AppColors.blue1, fontWeight: FontWeight.w400),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 16.h),
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
      ),
    );
  }
}