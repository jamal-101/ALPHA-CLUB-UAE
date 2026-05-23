import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/route/app_route.dart';
import '../../../../core/utils/app_color/app_color.dart';

class NewPasswordDialog extends StatelessWidget {
  const NewPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 447.h,
      width: 430.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        color: AppColors.appBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 20.0.r, right: 20.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    AppColors.radialGradiant1,
                    AppColors.radialGradiant2,
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(AssetPath.splashImage,
                  height: 50.h,
                    width: 70.w,
                    fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CommonText(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.sp,
                fontFamily: 'SFPro'
              ),
                color: AppColors.blue1,
                text: AppString.passwordChange),
            SizedBox(height: 12.h),
            CommonText(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                fontFamily: 'SFPro'
              ),
                color: AppColors.blueBase,
                text: AppString.returnTo),
            SizedBox(height: 57.h),
            CommonButton(onTap: (){
               Get.toNamed(AppRoute.loginScreen);
            }, text: AppString.cont)
          ],
        ),
      ),
    );
  }
}
