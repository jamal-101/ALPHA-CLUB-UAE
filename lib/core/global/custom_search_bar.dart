import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_color/app_color.dart';
import '../utils/app_image/app_image.dart';
import '../utils/app_string/app_string.dart';

class CustomSearchField extends StatelessWidget {
  CustomSearchField({super.key});

  final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.otpBorderColor,
        ),
      ),
      child: TextFormField(
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(
          color: AppColors.gold60,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),

          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 0.w),
            child: Image.asset(
              AssetPath.searchIcons,
              height: 20.h,
              width: 20.w,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 20.h,
          ),
          hintText: AppString.searchClubs,
          hintStyle: GoogleFonts.poppins(
            color: AppColors.gold60,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),

          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
