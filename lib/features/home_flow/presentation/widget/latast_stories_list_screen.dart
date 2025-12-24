import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> newsData = [
      {
        "image": AssetPath.latestStoriesImage,
        "title": "Global EV Market Surges with Record Sales",
        "desc":
            "Electric vehicle sales have reached unprecedented levels globally, driven by innovation, sustainability goals, and government incentives....",
        "time": "4 hours ago",
        "likes": 567,
      },
      {
        "image": AssetPath.latestStoriesImage,
        "title": "Global EV Market Surges with Record Sales",
        "desc":
            "Electric vehicle sales have reached unprecedented levels globally, driven by innovation, sustainability goals, and government incentives....",
        "time": "4 hours ago",
        "likes": 567,
      }, {
        "image": AssetPath.latestStoriesImage,
        "title": "Global EV Market Surges with Record Sales",
        "desc":
            "Electric vehicle sales have reached unprecedented levels globally, driven by innovation, sustainability goals, and government incentives....",
        "time": "4 hours ago",
        "likes": 567,
      },
    ];

    return ListView.builder(
      itemCount: newsData.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final item = newsData[index];
        return Container(
          margin: EdgeInsets.only(left: 20,bottom: 10.h,right: 20),
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
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.appBackgroundColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Image.asset(AssetPath.likeIcon,height: 16.h,width: 16),
                          SizedBox(width: 4.w),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                AppColors.blueLiner1,
                                AppColors.blueLiner2,
                              ],
                            ).createShader(bounds),
                            child: CommonText(
                                text: item["likes"].toString(),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: AppColors.appBackgroundColor,
                            )
                          )
                        ],
                      ),
                    ),
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
                        colors: [
                          AppColors.blueLiner1,
                          AppColors.blueLiner2,
                        ],
                      ),
                    ),child: Center(
                      child: CommonText(
                      fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.borderColor,
                        text: "A"),
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
                  color: AppColors.blue1,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp
                ),
                  text: item["title"],
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tabUnselectBorderColor,
                  ),
                  children: [
                    TextSpan(
                        text: item["desc"],
                    ),
                    const TextSpan(
                      text: " See More",
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
                    color: AppColors.green1,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    item["time"],
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 10.sp,
                      color: AppColors.green1,
                      fontWeight: FontWeight.w400,
                    ),
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
