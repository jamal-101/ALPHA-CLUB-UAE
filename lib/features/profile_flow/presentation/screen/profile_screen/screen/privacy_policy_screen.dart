import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(title: AppString.privacyPolicy),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                text: AppString.at,
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
                    text: AppString.yourPrivacyAndData,
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
                text: AppString.weCollect),
            SizedBox(height: 20.h),
            CommonText(
              maxLines: 10,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.allPersonal),
            SizedBox(height: 20.h),
            CommonText(
              maxLines: 10,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.youHaveThe) ,
            SizedBox(height: 20.h),
            CommonText(
              maxLines: 10,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.byUsing),
          ],
        ),
      ),
    );
  }
}
