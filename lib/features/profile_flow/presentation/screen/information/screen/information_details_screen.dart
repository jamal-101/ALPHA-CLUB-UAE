import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';

class InformationDetailsScreen extends StatelessWidget {
  const InformationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              CommonAppBar(title: AppString.information),
              SizedBox(height: 30.h),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.w,
                          color: AppColors.profileBorderColor,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AssetPath.informationImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                                radius: 7.0,
                                colors: [
                                  AppColors.radialGradiant1,
                                  AppColors.radialGradiant2,
                                ]),
                            shape: BoxShape.circle,
                          ),
                          child: Center(child: Image.asset(AssetPath.editeProfile,color: AppColors.goldColor1,height: 8.h,width: 8.w,))
                      ),
                    ),
                  ],
                ),
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
                  text: AppString.spouseName
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
                  text: AppString.childrenName
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
              SizedBox(height: 150.h),
              CommonButton(onTap: (){}, text: AppString.cont)
            ],
          ),
        ),
      ),
    );
  }
}