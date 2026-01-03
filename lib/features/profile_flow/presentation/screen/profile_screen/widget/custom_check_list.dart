import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckList extends StatelessWidget {
  const CustomCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCustomItem("Access to all Alpha networking events"),
        SizedBox(height: 6.h),
        _buildCustomItem("Exclusive member discounts and offers"),
        SizedBox(height: 6.h),
        _buildCustomItem("Priority event registration"),
        SizedBox(height: 6.h),
        _buildCustomItem("Access to co-working spaces"),
      ],
    );
  }

  Widget _buildCustomItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Image.asset(AssetPath.checkIcon,color: AppColors.blue1,height: 8.h,width: 8.w),
        ),
        const SizedBox(width: 6),
        Expanded(
          child:
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  AppColors.linearGradient1,
                  AppColors.linearGradient2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: CommonText(
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: AppColors.appBackgroundColor,
              text: text,)
          )
        ),
      ],
    );
  }
}