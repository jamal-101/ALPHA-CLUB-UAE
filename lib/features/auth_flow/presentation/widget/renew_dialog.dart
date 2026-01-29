import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_color/app_color.dart';

class RenewDialog extends StatelessWidget {
      RenewDialog({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        color: AppColors.appBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 16.0.r, right: 16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12.h),
            CommonText(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                fontFamily: 'SFPro',
                color: Color(0xFFFE9A00),
              ),
              text: AppString.youMembership,
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.borderColor,
                      ),
                      child: Center(
                        child: CommonText(
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.blueBase,
                          ),
                          text: "Cancel",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (controller.phoneController.text.isNotEmpty) {
                        await controller.sendRenewalRequest();
                      } else {
                        Get.snackbar('Error', 'Phone number not found. Please try again.');
                      }
                    },
                    child: Container(
                      height: 46.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xFF192948),
                      ),
                      child: Center(
                        child: CommonText(
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Color(0xFFFFFFFF),
                          ),
                          text: "Yes, Renew here",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}