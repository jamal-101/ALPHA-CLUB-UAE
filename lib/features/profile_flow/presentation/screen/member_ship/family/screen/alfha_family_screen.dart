import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/family/widget/all_stander_list.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/family/widget/family_covarage_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../profile_screen/screen/profile_screen.dart';
import '../widget/alpha_family_widget.dart';


class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22.h),
            AlphaFamilyWidget(),
            SizedBox(height: 16.h),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.blue1,
              ),
              text: AppString.familyCoverage,
            ),
            SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FamilyCoverageContainer(
                        title: AppString.mainMember,
                        subTitle: AppString.primaryAccount,
                        image: AssetPath.memberShipImage
                    ),
                    FamilyCoverageContainer(
                        title: AppString.mainMember,
                        subTitle: AppString.primaryAccount,
                        image: AssetPath.familyProfile
                    ),
                  ],
                ),
            SizedBox(height: 12.h),
            FamilyCoverageContainer(
                title: AppString.mainMember,
                subTitle: AppString.primaryAccount,
                image: AssetPath.childrenImage
            ),
            SizedBox(height: 16.h),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.blue1,
              ),
              text: AppString.allStandardFeatures,
            ),
            SizedBox(height: 16.h),
            AllStanderList(),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.appBackgroundColor,
                  borderRadius: BorderRadius.circular(8.0.r),
                  border: Border.all(
                      width: 1.w,
                      color: AppColors.otpBorderColor
                  )
              ),child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue1,
                    ),
                    text: AppString.perfectToFamilies,
                  ),
                  SizedBox(height: 4.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueBase,
                    ),
                    text: AppString.contactOurTeamToUpgrade,
                  ),
                  SizedBox(height: 24.h),
                  CommonButton(onTap: (){
                    ProfileScreen.isFamilyListVisible.value = false;
                    Get.toNamed(AppRoute.informationDetailsScreen);
                  }, text: AppString.getFamilyMemberShip)
                ],
              ),
            ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}