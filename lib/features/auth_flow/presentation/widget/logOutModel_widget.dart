import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/route/app_route.dart';
import '../../../../core/stroge/storage_service.dart';
import '../../../../core/utils/app_color/app_color.dart';

class LogOutModelWidget extends StatelessWidget {
  const LogOutModelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        color: AppColors.appBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 16.0.r, right: 16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                GestureDetector(
                  onTap: (){
                    _disablePopUp();
                  },
                    child: Icon(Icons.close_sharp)),
              ],
            ),
            SizedBox(height: 0.h,),
            CommonText(
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                    fontFamily: 'SFPro'
                ),
                color: AppColors.blue1,
                text: "Change Your Password?"),
            SizedBox(height: 12.h),
            CommonText(
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                fontFamily: 'SFPro',
                color: Color(0xFFFE9A00),
              ),
              text: AppString.forYour,
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _disablePopUp();
                   // Get.toNamed(AppRoute.homeScreen);
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
                          text: "Maybe Later",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await LocalStorage.setBool('hasPasswordSave', true);
                      Navigator.pop(context);
                      Get.toNamed(AppRoute.changePasswordScreen);
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
                          text: "Yes, Update Now",
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


Future<void> _disablePopUp() async {
  await LocalStorage.setBool('hasPasswordSave', true);
  Get.back();
}