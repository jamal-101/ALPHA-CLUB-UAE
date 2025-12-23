import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(title: AppString.aboutUs),
            SizedBox(height: 20.h),
            CommonText(
              textAlign: TextAlign.start,
              maxLines: 5,
              fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.blue1,
                text: AppString.aboutUs1),
            SizedBox(height: 16.h),
            CommonText(
                textAlign: TextAlign.start,
                maxLines: 5,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.blue1,
                text: AppString.aboutUs1),
            SizedBox(height: 20.h),
            CommonText(
              fontWeight: FontWeight.w500,
                text: AppString.ourMission)

          ],
        ),
      ),
    );
  }
}
