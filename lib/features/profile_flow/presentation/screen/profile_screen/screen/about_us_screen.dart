import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/what_offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

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
            CommonAppBar(title: AppString.aboutUs,onTap:(){
              Get.back();
            },),
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
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.blue1,
                text: AppString.aboutUs1),
            SizedBox(height: 20.h),
            CommonText(
              fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.goldColor1,
                text: AppString.ourMission),
            SizedBox(height: 10.h),
            CommonText(
                textAlign: TextAlign.start,
                maxLines: 5,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.blue1,
                text: AppString.toSimplify), 
            SizedBox(height: 20.h),
            CommonText(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.goldColor1,
                text: AppString.ourVision),
            SizedBox(height: 10.h),
            CommonText(
                textAlign: TextAlign.start,
                maxLines: 5,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.blue1,
                text: AppString.toBecome),
            SizedBox(height: 20.h),
            CommonText(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.goldColor1,
                text: AppString.whatWeOffer),
            SizedBox(height: 20.h),
            Expanded(child: WhatOfferWidget()),
          ],
        ),
      ),
    );
  }
}
