import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(title: AppString.changePassword),
            SizedBox(height: 40.h),
            CommonText(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFPro',
                color: AppColors.blue1,
              ),
                text: AppString.changePassword),
            SizedBox(height: 12.h),
            CommonTextField(
              isPopins: true,
                isPassword: true,
              hintText: AppString.currentPassword,
            ),
            SizedBox(height: 24.h),
            CommonText(
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SFPro',
                  color: AppColors.blue1,
                ),
                text: AppString.newPassword),
            SizedBox(height: 12.h),
            CommonTextField(
              isPopins: true,
              isPassword: true,
              hintText: AppString.newPassword,
            ),
            SizedBox(height: 24.h),
            CommonText(
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SFPro',
                  color: AppColors.blue1,
                ),
                text: AppString.confirmPassword),
            SizedBox(height: 12.h),
            CommonTextField(
              isPopins: true,
              isPassword: true,
              hintText: AppString.currentPassword,
            ),
            Spacer(),
            CommonButton(onTap: (){}, text: AppString.save),
            SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}
