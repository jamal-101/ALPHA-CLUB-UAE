import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComparisonButton extends StatelessWidget {
  const ComparisonButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 7,
          colors: [
            AppColors.radialGradiant1,
            AppColors.radialGradiant2,
          ],
        ),
      ),child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  AppColors.linearGradient1,
                  AppColors.linearGradient2,
                ],
              ).createShader(bounds);
            },
            child: Text(
              AppString.feature,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white, // important
              ),
            ),
          ),
          SizedBox(width: 90.w),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  AppColors.linearGradient1,
                  AppColors.linearGradient2,
                ],
              ).createShader(bounds);
            },
            child: Text(
              AppString.regular,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white, // important
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  AppColors.linearGradient1,
                  AppColors.linearGradient2,
                ],
              ).createShader(bounds);
            },
            child: Text(
              AppString.family,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white, // important
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
