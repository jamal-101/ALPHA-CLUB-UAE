import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBrandCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const CustomBrandCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 189.w,
      padding: const EdgeInsets.only(top: 25,bottom: 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.otpBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2E436A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'SFPro',
            ),
          ),
        ],
      ),
    );
  }
}