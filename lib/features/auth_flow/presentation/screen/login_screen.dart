import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.homeScreen);
                      },
                      child: Container(
                        height: 27.h,
                        width: 57.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.skipColor,
                          )
                        ),child: Center(
                          child: CommonText(
                          fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.skipColor,
                            text: "Skip"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Image.asset(AssetPath.splashImage, height: 132, width: 267),
              CommonText(
                text: AppString.sinIn,
                color: AppColors.whiteFoundation,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
              ),
              SizedBox(height: 10.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.enterYourMobile,
                color: AppColors.whiteFoundation,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              SizedBox(height: 2.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.toAccess,
                color: AppColors.whiteFoundation,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              SizedBox(height: 34.h),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.r),
                      topRight: Radius.circular(45.r),
                    ),
                    color: AppColors.appBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SizedBox(height: 85.h),
                        CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro'
                          ),
                          text: AppString.contactNumber,
                        ),
                        SizedBox(height: 12.h),
                        IntlPhoneField(
                          decoration: InputDecoration(
                            hintText: AppString.enterYourContact,
                            hintStyle: TextStyle(
                              color: AppColors.blue1.withValues(alpha: 0.5),
                              fontSize: 14.sp,
                              fontFamily: 'SFPro',
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.blue1.withValues(alpha: 0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.blue1.withValues(alpha: 0.2),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AppColors.blue1,
                                width: 1.5,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                          ),
                          initialCountryCode: 'BD',
                          dropdownTextStyle: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'SFPro',
                            color: AppColors.blue1,
                            fontWeight: FontWeight.w500,
                          ),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'SFPro',
                            color: AppColors.blue1,
                            fontWeight: FontWeight.w500,
                          ),
                          flagsButtonPadding: EdgeInsets.only(left: 12.w),
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.blue1,
                            size: 22.sp,
                          ),
                          dropdownIconPosition: IconPosition.trailing,
                          showCountryFlag: true,
                          showDropdownIcon: true,
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Colors.white,
                            searchFieldInputDecoration: InputDecoration(
                              labelText: 'Search Country',
                              labelStyle: TextStyle(
                                color: AppColors.blue1,
                                fontFamily: 'SFPro',
                                fontSize: 12.sp,
                              ),
                              hintText: 'Type country name',
                              hintStyle: TextStyle(
                                color: AppColors.blue1.withValues(alpha: 0.5),
                                fontFamily: 'SFPro',
                                fontSize: 12.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.blue1,
                                size: 20.sp,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.blue1.withValues(alpha: 0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.blue1.withValues(alpha: 0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: AppColors.blue1,
                                  width: 1.5,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                            ),
                            countryCodeStyle: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'SFPro',
                              color: AppColors.blue1,
                              fontWeight: FontWeight.w600,
                            ),
                            countryNameStyle: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'SFPro',
                              color: AppColors.blue1,
                              fontWeight: FontWeight.w400,
                            ),
                            listTileDivider: Divider(
                              color: AppColors.blue1.withValues(alpha: 0.1),
                              height: 0.5,
                            ),
                            listTilePadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            padding: EdgeInsets.all(12.w),
                          ),
                          onChanged: (phone) {
                            controller.phoneNumber.value = phone.completeNumber;
                          },
                        ),
                        SizedBox(height: 24.h),
                        CommonText(
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            fontFamily: 'SFPro'
                          ),
                          text: AppString.newPassword,
                        ),
                        SizedBox(height: 12.h),
                        CommonTextField(
                          isPassword: true,
                          hintText: '********',
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(AppRoute.newPasswordScreen);
                              },
                              child: CommonText(
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blue1,
                                    fontFamily: 'SFPro'
                                ),
                                text: AppString.forgetPass,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Obx(() => CommonButton(
                          onTap: controller.isLoading.value 
                            ? () {} 
                            : () => controller.login(),
                          text: controller.isLoading.value 
                            ? 'Loading...' 
                            : AppString.sinIn,
                        )),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.blue1,
                                ),
                                text: AppString.becomeAnd),
                            SizedBox(width: 10.w),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.linearGradient1,
                                  AppColors.linearGradient2,
                                ],
                              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                              child: GestureDetector(
                                onTap: (){
                                  Get.toNamed(AppRoute.memberFormScreen);
                                },
                                child: Text(
                                  AppString.applyHere,
                                  style: TextStyle(
                                    fontFamily: 'SFPro',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFDFBB0B)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // CommonBottomNabVar(selectedIndex: 2)
            ],
          ),
        ),
      ),
    );
  }
}
