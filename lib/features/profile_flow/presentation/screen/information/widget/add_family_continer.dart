import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFamilyContainer extends StatelessWidget {
  const AddFamilyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      width: 172.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.green1.withValues(alpha: 0.15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.add,color: AppColors.green1),
          SizedBox(width: 5.w),
          CommonText(
            fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: AppColors.green1,
              text: AppString.addFamilyMember)
        ],
      ),
    );
  }
}
