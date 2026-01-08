import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widget/all_features_listview.dart';
import '../widget/alpha_member_ship_widget.dart';

class AlphaScreen extends StatelessWidget {
     AlphaScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            AlphaMemberShipWidget(),
            SizedBox(height: 16.h),
            CommonText(
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.blue1,
              ),
                text: AppString.allFeaturesIncluded,
            ),
            SizedBox(height: 16.h),
            AllFeaturesListview(),
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
                      text: AppString.readYtoJoin,
                  ),
                  SizedBox(height: 4.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueBase,
                    ),
                      text: AppString.contactOurTeam,
                  ),
                  SizedBox(height: 24.h),
                  CommonButton(onTap: (){
                    Get.toNamed(AppRoute.informationScreen);
                  }, text: AppString.getMemberShip)
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