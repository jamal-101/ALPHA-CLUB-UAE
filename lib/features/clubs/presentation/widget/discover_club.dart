import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DiscoverClub extends StatelessWidget {
  const DiscoverClub({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> eventData = [
      {
        "title": "Veo Gym",
        "desc": "Memberships",
        "image": AssetPath.gymImage
      },
      {
        "title": "Atlantis",
        "desc": "3 Memberships",
        "image": AssetPath.gymImage
      },
      {
        "title": "5iron Indoor Golf",
        "desc": "Available",
        "image": AssetPath.gymImage
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: eventData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.99,
      ),
      itemBuilder: (context, index) {
        final item = eventData[index];
        return GestureDetector(
          onTap: (){
            Get.toNamed(AppRoute.clubDetailsScreen);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4,right: 4,top: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      item["image"]!,
                      height: 120.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro'
                        ),
                        textAlign: TextAlign.start,
                        text:  item["title"]!,),
                      SizedBox(height: 4.h),
                      CommonText(
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: AppColors.blueBase,
                        ),
                        textAlign: TextAlign.start,
                        text:  item["desc"]!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}