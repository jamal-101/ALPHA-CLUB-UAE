import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_color/app_color.dart';

class CommontTextFieldEmail extends StatelessWidget {
  const CommontTextFieldEmail({
    super.key,
    this.containerColor = AppColors.fillColor,
    this.borderColor = AppColors.borderColor,
    this.height,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.validator,
    this.isPopins = false,
  });

  final Color containerColor;
  final double? height;
  final Color borderColor;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isPopins;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.blueBase,
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: containerColor,
            hintText: hintText,
            hintStyle: isPopins ? GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
              color: AppColors.blueBase,
            ) : TextStyle(
                fontFamily: 'SFPro',
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.blueBase
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: borderColor, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: borderColor, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.blueBase, width: 1.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: const Color(0xFF0F4C5C).withValues(alpha: 0.7),
              size: 20.sp,
            ),
          ),
        );
  }
}