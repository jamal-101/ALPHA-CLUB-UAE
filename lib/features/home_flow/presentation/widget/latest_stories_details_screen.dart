import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LatestStoriesDetailsScreen extends StatelessWidget {
  const LatestStoriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    AssetPath.latestStoriesImage,
                    height: 219.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppColors.gold50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_sharp,
                        size: 22.sp,
                        color: AppColors.blue1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.blueLiner1, AppColors.blueLiner2],
                    ),
                  ),
                  child: Center(
                    child: CommonText(
                      fontSize: 18,
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
                        fontSize: 20.sp,
                        fontFamily: 'SFPro',
                        color: AppColors.blue1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "World Automotive News",
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tabUnselectBorderColor,
                      ),
                    ),
                  ],
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
                text: AppString.description),
            SizedBox(height: 16.h),
            CommonText(
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.blue1,
                text: AppString.landingAutoMotive),
          ],
        ),
      ),
    );
  }
}
