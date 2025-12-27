import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color/app_color.dart';
import '../utils/app_string/app_string.dart';


class MessageField extends StatelessWidget {
  final TextEditingController textController;

  const MessageField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 166.h,
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
      ),
      child: TextField(
        controller: textController,
        style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.blueBase
        ),
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 12, top: 12, bottom: 10),
          hintText: AppString.writeYourMessage,
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blueBase,
          ),
          filled: true,
          fillColor: AppColors.appBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
