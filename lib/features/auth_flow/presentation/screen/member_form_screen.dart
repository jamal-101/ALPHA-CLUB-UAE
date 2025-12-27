import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/global/message_field.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/global/common_text_field.dart';
import '../../../../core/utils/app_color/app_color.dart';


class MemberFormScreen extends StatelessWidget {
      MemberFormScreen({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
                  // Center(
                  //   child: CommonText(
                  //     style: TextStyle(
                  //       fontFamily: 'SFPro',
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 20.sp,
                  //       color: AppColors.blue1,
                  //     ),
                  //     text: AppString.memberForm,
                  //   ),
                  // ),
              CommonAppBar(title: AppString.memberForm,onTap: (){
                Get.toNamed(AppRoute.loginScreen);
              }),
              SizedBox(height: 24.h),
              CommonText(
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                    fontFamily: 'SFPro'
                ),
                text: AppString.name,
              ),
              SizedBox(height: 12.h),
              CommonTextField(
                borderColor: AppColors.otpBorderColor,
                containerColor: AppColors.appBackgroundColor,
                hintText: AppString.enterYOurName
              ),
              SizedBox(height: 24.h),
              CommonText(
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                    fontFamily: 'SFPro'
                ),
                text: AppString.email,
              ),
              SizedBox(height: 12.h),
              CommonTextField(
                  borderColor: AppColors.otpBorderColor,
                  containerColor: AppColors.appBackgroundColor,
                  hintText: AppString.enterEmail
              ),
              SizedBox(height: 24.h),
              CommonText(
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                    fontFamily: 'SFPro'
                ),
                text: AppString.message,
              ),
              SizedBox(height: 12.h),
              MessageField(textController: textController),
              SizedBox(height: 16.h),
              CommonButton(onTap: (){
                Get.toNamed(AppRoute.loginScreen);
              }, text: AppString.saveChange)
            ],
          ),
        ),
      ),
    );
  }
}
