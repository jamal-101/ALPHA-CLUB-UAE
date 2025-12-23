import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/global/common_text_field.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';
import '../widget/profile_data_container.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16,right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(title: AppString.personalInformation),
            SizedBox(height: 30.h),
            ProfileDataContainer(
              showEditButton: false,
              imagePath: AssetPath.userProfile, userName: AppString.userName,
              membershipType: AppString.alphaMember, userId: AppString.userId,
            ),
            SizedBox(height: 16.h),
            CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.blue1,
                ),
                text: AppString.fullName
            ),
            SizedBox(height: 8.h),
            CommonTextField(
              isPopins: true,
              containerColor: AppColors.appBackgroundColor,
              hintText: AppString.michealAnderson,
            ),
            SizedBox(height: 16.h),
            CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.blue1,
                ),
                text: AppString.email
            ),
            SizedBox(height: 8.h),
            CommonTextField(
              isPopins: true,
              containerColor: AppColors.appBackgroundColor,
              hintText: AppString.gmail,
            ),
            SizedBox(height: 16.h),
            CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.blue1,
                ),
                text: AppString.address
            ),
            SizedBox(height: 8.h),
            CommonTextField(
              isPopins: true,
              containerColor: AppColors.appBackgroundColor,
              hintText: AppString.location,
            ),
          ],
        ),
      ),
    );
  }
}
