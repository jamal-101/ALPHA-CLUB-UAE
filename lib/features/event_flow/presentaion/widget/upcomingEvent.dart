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
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final item = eventData[index];
        return GestureDetector(
          onTap: (){
            Get.toNamed(AppRoute.eventDetailsScreen);
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
                      height: 110.h,
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
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(AssetPath.calenderIcon,height: 14.h,width: 14.w),
                              SizedBox(width: 4.w),
                             CommonText(
                               style: TextStyle(
                                 fontFamily: "SFPro",
                                 fontWeight: FontWeight.w400,
                                 fontSize: 10,
                                 color: AppColors.foundationWhite1
                               ),
                                 text: item["date"]!,
                             )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 12.sp, color: Colors.orange),
                              SizedBox(width: 4.w),
                              CommonText(
                                style: TextStyle(
                                    fontFamily: "SFPro",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: AppColors.foundationWhite1
                                ),
                                text: item["time"]!,
                              ),
                            ],
                          ),
                        ],
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