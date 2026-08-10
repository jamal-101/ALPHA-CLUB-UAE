import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/commont_text_field_email.dart';
import '../../../../core/helper/from_validation.dart';
import '../../../../core/route/app_route.dart';

class SingInVerify extends StatelessWidget {
  SingInVerify({super.key});

  final LoginController phoneController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.radialGradiant2,
        surfaceTintColor: AppColors.radialGradiant2,
        elevation: 0,
        leadingWidth: 50.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 30.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.white70.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 9.w),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black87.withValues(alpha: 0.9),
                    size: 28.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: 90.h),
              Image.asset(AssetPath.splashImage, height: 132, width: 267),
              SizedBox(height: 70.h),
              CommonText(
                style: TextStyle(
                  fontFamily: 'SFPro',
                  color: AppColors.whiteFoundation,
                  fontWeight: FontWeight.w400,
                  fontSize: 22.sp,
                ),
                text: AppString.forgetPass,
              ),
              SizedBox(height: 10.h),
              CommonText(
                textAlign: TextAlign.center,
                text: AppString.enterYourMobile,
                color: AppColors.whiteFoundation1,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
              SizedBox(height: 55.h),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.r),
                    topRight: Radius.circular(45.r),
                  ),
                  color: AppColors.appBackgroundColor,
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  // physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 100.h),
                          CommonText(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue1,
                              fontFamily: 'SFPro',
                            ),
                            text: AppString.email,
                          ),
                          SizedBox(height: 12.h),
                          CommontTextFieldEmail(
                            validator: FormValidation.validateEmail,
                            controller: phoneController.forgotEmailController,
                            borderColor: AppColors.otpBorderColor,
                            containerColor: Color(0xff0fff5f7fa).withValues(alpha: 0.2),
                            hintText: AppString.enterEmail,
                          ),
                          SizedBox(height: 60.h),
                          Obx(
                            () => CommonButton(
                              // isLoading: phoneController.isLoading.value,
                              onTap: () {
                                if (!phoneController.isLoading.value) {
                                  phoneController.sendForgotPasswordOtp();
                                }
                              },
                              text: phoneController.isLoading.value
                                  ? "Sending..."
                                  : AppString.sendOtp,
                            ),
                          ),
                          // CommonButton(onTap: (){
                          //   Get.toNamed(AppRoute.singInOtp);
                          // }, text: AppString.sendOtp),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
