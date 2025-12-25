import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../../../core/utils/app_color/app_color.dart';


class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 254.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        color: AppColors.appBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.close,size: 24.h,color: AppColors.blue1)),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CommonText(
                style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1
                ),
                text: AppString.logout),
            SizedBox(height: 10.h),
            CommonText(
                style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1
                ),
                text: AppString.areYouSure),
            SizedBox(height: 54.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: 46.h,
                    width: 128.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.borderColor
                    ),child: Center(
                    child: CommonText(
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.blueBase
                      ),
                        text: AppString.no
                    ),
                  ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    height: 46.h,
                    width: 128.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.redColor.withValues(alpha: 0.1)
                    ),child: Center(
                    child: CommonText(
                        style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.redColor
                        ),
                        text: AppString.yes
                    ),
                  ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
