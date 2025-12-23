import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';


class AlphaMemberShipWidget extends StatelessWidget {
  const AlphaMemberShipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue1.withValues(alpha: 0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AssetPath.memberShipImage,
                        height: 25.h,
                        width: 25,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      color: AppColors.blue1,
                      text: AppString.regularMemberShip,
                    ),
                    CommonText(
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      color: AppColors.blueBase,
                      text: AppString.allEssential,
                    ),
                    CommonText(
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      color: AppColors.blueBase,
                      text: AppString.professionals,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CommonText(
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.foundationWhite,
              ),
              text: AppString.withThe,
            ),
          ],
        ),
      ),
    );
  }
}
