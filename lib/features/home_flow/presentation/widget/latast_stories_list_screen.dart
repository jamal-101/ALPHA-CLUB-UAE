import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
import 'package:alpha_club/features/home_flow/presentation/widget/latest_stories_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/service/api/api_enpoint.dart';

class NewsListView extends StatelessWidget {
  NewsListView({super.key});

  final HomeController homeController = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {


    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (homeController.hasMoreStories && !homeController.isMoreStoriesLoading.value) {
          homeController.fetchLatestStories(isLoadMore: true);
        }
      }
    });

    return Obx(() {

      return RefreshIndicator(
        color: Color(0xFF233A66),
        backgroundColor: AppColors.appBackgroundColor,
        onRefresh: () async {
          await homeController.fetchLatestStories(isLoadMore: false);
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: homeController.stories.length + 1,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            if (index == homeController.stories.length) {
              return Obx(() {
                return homeController.isMoreStoriesLoading.value
                    ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox(height: 20);
              });
            }

            final item = homeController.stories[index];
            // final List images = homeController.singleStoryDetails['image'] ?? [];
            final List storyImages = item['image'] is List ? item['image'] : [item['image']];

            return Container(
              margin: EdgeInsets.only(left: 20, bottom: 10.h, right: 20),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.storiesBorderColor, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child:
                        // Image.network(
                        //   "${ApiEndPoint.imageBaseUrl}${item['image']}",
                        //   height: 200.h,
                        //   width: double.infinity,
                        //   fit: BoxFit.cover,
                        // ),
                        _storyImageSlider(storyImages, index),
                      ),
                      Positioned(
                        top: 12.h,
                        right: 10.w,
                        child: Obx(() {
                          final String storyId = item['_id'] ?? "";
                          bool currentIsLiked = homeController.storyIsLiked[storyId] ?? (item['isLiked'] ?? false);
                          int currentCount = homeController.storyLikesCount[storyId] ?? (item['likeCount'] ?? 0);
                          return GestureDetector(
                            onTap: () {
                              homeController.toggleLikeStory(storyId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: AppColors.appBackgroundColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  currentIsLiked == true
                                      ? Icon(Icons.thumb_up, size: 18.sp, color: Colors.blueAccent)
                                      : Image.asset(AssetPath.likeIcon, height: 16, width: 16),
                                  SizedBox(width: 4.w),
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [AppColors.blueLiner1, AppColors.blueLiner2],
                                    ).createShader(bounds),
                                    child: CommonText(
                                      text: "$currentCount",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.appBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Container(
                        height: 25.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.blueLiner1, AppColors.blueLiner2],
                          ),
                        ),
                        child: Center(
                          child: CommonText(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.borderColor,
                            text: item['club'] != null ? item['club']['name'][0] : "A",
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['club'] != null ? item['club']['name'] : "Alpha Club",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'SFPro',
                              color: AppColors.blue1,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      color: AppColors.blue1,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                    text: item["title"],
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.tabUnselectBorderColor,
                      ),
                      children: [
                        TextSpan(
                          text: (item["description"] ?? "")
                              .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), "")
                              .trim()
                              .split('')
                              .take(105)
                              .join('') + "...",
                        ),
                        TextSpan(
                          text: "  ${AppString.seeMore}",
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => LatestStoriesDetailsScreen(storyId: item['_id']));
                            },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16.sp,
                        color: AppColors.green1,
                      ),
                      SizedBox(width: 5.w),
                      CommonText(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.green1,
                        text: getFormattedDate(item["createdAt"]),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}



String getFormattedDate(String? createdAt) {
  if (createdAt == null || createdAt.isEmpty) return "";
  DateTime dateTime = DateTime.parse(createdAt).toLocal();
  return DateFormat('hh:mm a').format(dateTime);
}


///>>>>>>>>>>>>>>>>>>>>>>>> StoryImageSlider <<<<<<<<<<<<<<<<<<<<<///

Widget _storyImageSlider(List images, int storyIndex) {
  final HomeController homeController = Get.put(HomeController());
  // if (images.isEmpty || images[0] == null) {
  //   return Container(
  //     height: 200.h,
  //     width: double.infinity,
  //     color: Colors.grey[200],
  //     child: const Icon(Icons.image_not_supported),
  //   );
  // }

  return Column(
    children: [
      CarouselSlider(
        options: CarouselOptions(
          height: 200.h,
          viewportFraction: 1.0,
          autoPlay: images.length > 1,
          enlargeCenterPage: false,
          onPageChanged: (slideIndex, reason) {
            homeController.sliderIndices[storyIndex] = slideIndex;
          },
        ),
        items: images.map((imageUrl) {
          return Image.network(
            "${ApiEndPoint.imageBaseUrl}$imageUrl",
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
          );
        }).toList(),
      ),
      if (images.length > 1)
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Obx(() {
            int currentSlide = homeController.sliderIndices[storyIndex] ?? 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentSlide == entry.key
                        ? AppColors.green1
                        : Colors.grey.withValues(alpha: 0.3),
                  ),
                );
              }).toList(),
            );
          }),
        ),
    ],
  );
}
