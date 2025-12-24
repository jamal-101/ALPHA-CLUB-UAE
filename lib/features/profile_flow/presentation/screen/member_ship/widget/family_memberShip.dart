import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_color/app_color.dart';

class FamilyMembership extends StatelessWidget {
  const FamilyMembership({super.key});

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
                      color: AppColors.goldColor1.withValues(alpha: 0.2),
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
                      text: AppString.familyMemberShip,
                    ),
                    CommonText(
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      color: AppColors.blue1,
                      text: AppString.allFeatures,
                    ),
                    CommonText(
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      color: AppColors.blue1,
                      text: AppString.benefits,
                    ),
                  ],
                ),
              ],
            ),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blue1,
              ),
              text: AppString.memberShipType1,
            ),
            SizedBox(height: 2.h),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.blue1,
              ),
              text: AppString.familyAccess,
            ),
            SizedBox(height: 8.h),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.goldColor1,
              ),
              text: AppString.keYBenefits,
            ),
            SizedBox(height : 8.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 15,width: 15,),
                SizedBox(width: 6.w),
                CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                  ),
                  text: AppString.digitalMemberShipCard,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 15,width: 15,),
                SizedBox(width: 6.w),
                CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                  ),
                  text: AppString.exclusiveOffer,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 15,width: 15,),
                SizedBox(width: 6.w),
                CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                  ),
                  text: AppString.industryEvents,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 15,width: 15,),
                SizedBox(width: 6.w),
                CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                  ),
                  text: AppString.clubFacilities,
                ),
              ],
            ),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.green1,
              ),
              text: AppString.moreFeatures,
            ),
          ],
        ),
      ),
    );
  }
}
