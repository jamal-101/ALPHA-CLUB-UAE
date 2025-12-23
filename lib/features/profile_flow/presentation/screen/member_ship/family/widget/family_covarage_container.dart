import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FamilyCoverageContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;

  const FamilyCoverageContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 189.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.otpBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              color: AppColors.goldColor1.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8.w),
            child: Image.asset(
              image,
              color: AppColors.goldColor1,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFPro',
                    color: AppColors.blue1,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    color: AppColors.foundationWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}