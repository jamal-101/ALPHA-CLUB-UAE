import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UpComingEvent extends StatelessWidget {
  const UpComingEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> eventData = [
      {
        "title": "Festive Brunch at JGE",
        "desc": "Filled with fun, laughter and Christmas glee",
        "date": "Dec 06, 2025",
        "time": "07:00 PM",
        "image": AssetPath.upComingEventImage
      },
      {
        "title": "Jumeirah One",
        "desc": "Filled with fun, laughter and Christmas glee",
        "date": "Dec 06, 2025",
        "time": "07:00 PM",
        "image": AssetPath.gridImage1
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
        childAspectRatio: 0.70,
      ),
      itemBuilder: (context, index) {
        final item = eventData[index];
        return GestureDetector(
          onTap: () => Get.toNamed(AppRoute.eventDetailsScreen),
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
                  padding: EdgeInsets.all(4.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      item["image"]!,
                      height: 144.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 6.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro',
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          text: item["title"]!,
                        ),
                        SizedBox(height: 6.h),
                        CommonText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: AppColors.blueBase,
                          ),
                          textAlign: TextAlign.start,
                          text: item["desc"]!,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Image.asset(
                                      AssetPath.calenderIcon, height: 20.h,
                                      width: 20.w,
                                      color: AppColors.goldColor1),
                                  SizedBox(width: 4.w),
                                  Flexible(
                                      child: CommonText(
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.foundationWhite1
                                        ),
                                        text:  item["date"]!,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 20.sp,
                                    color: AppColors.goldColor1),
                                SizedBox(width: 2.w),
                                CommonText(
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.foundationWhite1
                                  ),
                                  text:  item["time"]!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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