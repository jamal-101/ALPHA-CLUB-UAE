import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/features/home_flow/controller/home_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsListView extends StatelessWidget {
  NewsListView({super.key});

  final HomeController likeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> newsData = [
      {
        "image": AssetPath.latestStoriesImage,
        "title": "Global EV Market Surges with Record Sales",
        "desc":
            "Electric vehicle sales have reached unprecedented levels globally, driven by innovation, sustainability goals, and government incentives....",
        "time": "4 hours ago",
      },
      {
        "image": AssetPath.latestStoriesImage,
        "title": "Global EV Market Surges with Record Sales",
        "desc":
            "Electric vehicle sales have reached unprecedented levels globally, driven by innovation, sustainability goals, and government incentives....",
        "time": "4 hours ago",
      },
      {
        "image": AssetPath.latestStoriesImage,
        "title": "Global EV Market Surges with Record Sales",
        "desc":
            "Electric vehicle sales have reached unprecedented levels globally, driven by innovation, sustainability goals, and government incentives....",
        "time": "4 hours ago",
      },
    ];

    return ListView.builder(
      itemCount: newsData.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final item = newsData[index];
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
                    child: Image.asset(
                      item["image"],
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () {
                        likeController.toggleLike(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appBackgroundColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Obx(() {
                          bool currentIsLiked = likeController.isLiked(index);
                          int currentCount = currentIsLiked
                              ? likeController.baseLikeCount + 1
                              : likeController.baseLikeCount;
                          return Row(
                            children: [
                              currentIsLiked
                                  ? Icon(
                                      Icons.thumb_up,
                                      size: 18.sp,
                                      color: Colors.blueAccent,
                                    )
                                  : Image.asset(
                                      AssetPath.likeIcon,
                                      height: 16,
                                      width: 16,
                                    ),

                              SizedBox(width: 4.w),
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    AppColors.blueLiner1,
                                    AppColors.blueLiner2,
                                  ],
                                ).createShader(bounds),
                                child: CommonText(
                                  text: "$currentCount",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.appBackgroundColor,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  // ),
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
                        text: "A",
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alpha Club",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'SFPro',
                          color: AppColors.blue1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "World Automotive News",
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.tabUnselectBorderColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              CommonText(
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
                    fontWeight: FontWeight.w400,
                    color: AppColors.tabUnselectBorderColor,
                  ),
                  children: [
                    TextSpan(text: item["desc"]),
                    TextSpan(
                      text: " See More",
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoute.latestStoriesDetailsScreen);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16.sp, color: AppColors.green1),
                  SizedBox(width: 5.w),
                  CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.green1,
                    text: item["time"],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
