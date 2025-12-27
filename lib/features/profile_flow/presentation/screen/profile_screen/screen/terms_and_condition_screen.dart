import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(title: AppString.termsAndCondition,onTap: (){
              Get.back();
            },),
            SizedBox(height: 24.h),
            RichText(
              text: TextSpan(
                text: AppString.byUsingThe,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.blue1,
                ),
                children: [
                  TextSpan(
                      text: '  '
                  ),
                  TextSpan(
                    text: AppString.alphaClub,
                    style: GoogleFonts.poppins(
                        color: AppColors.goldColor1,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp
                    ),
                  ),
                  TextSpan(
                      text: '  '
                  ),
                  TextSpan(
                    text: AppString.mobileApp,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.blue1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CommonText(
                maxLines: 10,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.userMustProvide),
            SizedBox(height: 20.h),
            CommonText(
                maxLines: 10,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.subscription),
            SizedBox(height: 20.h),
            CommonText(
                maxLines: 10,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.keyBank),
          ],
        ),
      ),
    );
  }
}
