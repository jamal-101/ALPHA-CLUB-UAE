import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ClubDetailsScreen extends StatelessWidget {
  const ClubDetailsScreen({super.key});

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
                    AssetPath.gymImage,
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
            CommonText(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.blue1,
                text: AppString.veoGym
            ),
            SizedBox(height: 8.h),
            CommonText(
                style: TextStyle(
                    color: AppColors.blue1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'SFPro'
                ),
                text: AppString.membership5),
            SizedBox(height: 12.h),
            Row(
              children: [
                Image.asset(AssetPath.locationIcon,height: 20.h,width: 20.w),
                SizedBox(width: 5.w),
                CommonText(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blue1,
                  text: AppString.sponsorLocation,
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
                fontSize: 16,
                color: AppColors.blue1,
                text: AppString.description),
            SizedBox(height: 16.h),
            CommonText(
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.landingAutoMotive),
            SizedBox(height: 16.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 12.h,width: 12.w,),
                SizedBox(width: 6.w),
                CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                    text: AppString.choiceOf
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 12.h,width: 12.w,),
                SizedBox(width: 6.w),
                CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                    text: AppString.validMon
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Image.asset(AssetPath.checkIcon,height: 12.h,width: 12.w,),
                SizedBox(width: 6.w),
                CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                    text: AppString.reservationRec
                )
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.otpBorderColor,
                  ),
                  color: AppColors.appBackgroundColor
              ),child: Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  CommonText(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue1,
                      text: AppString.termsAndCondition),
                  SizedBox(height: 8.h),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2,left: 9),
                      child: Container(
                        height: 5.w,
                        width: 5.w,
                        decoration: BoxDecoration(
                          color: AppColors.blueBase,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(width: 9.w),
                    CommonText(
                        color: AppColors.blueBase,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        text: AppString.validFor)
                  ],),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 9,left: 9),
                        child: Container(
                          height: 5.w,
                          width: 5.w,
                          decoration: BoxDecoration(
                            color: AppColors.blueBase,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 9.w),
                      Expanded(
                        child: CommonText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            color: AppColors.blueBase,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            text: AppString.cannotBe),
                      ),
                    ],),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 9),
                        child: Container(
                          height: 5.w,
                          width: 5.w,
                          decoration: BoxDecoration(
                            color: AppColors.blueBase,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 9.w),
                      Expanded(
                        child: CommonText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            color: AppColors.blueBase,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            text: AppString.reservation),
                      )
                    ],),
                  SizedBox(height: 10.h,),
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}
