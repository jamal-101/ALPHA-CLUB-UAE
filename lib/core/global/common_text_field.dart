import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommonTextField extends StatelessWidget {


  const CommonTextField({
    super.key,
    this.containerColor = AppColors.fillColor,
    this.borderColor = AppColors.borderColor,
    this.height,
    this.hintText,
    this.prefixIcon,
    this.isPassword = false,
  });

  final Color containerColor;
  final double? height;
  final Color borderColor;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {

    RxBool isVisible = false.obs;

    return Obx(()=>
      Container(
        height: height?.h ?? 50.h,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(width: 1.w, color: borderColor),
        ),
        child: TextFormField(
          style: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blueBase
          ),
          obscureText: isVisible.value,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blueBase
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 25.w,
              maxHeight: 50.h,
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
              padding: EdgeInsets.only(left: 13.w,right: 2),
              child: prefixIcon,
            )
                : null,
            suffixIcon: isPassword
                ? InkWell(
              onTap: () => isVisible.value = !isVisible.value,
              child: Icon(
                isVisible.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFF808080),
              ),
            ) : null,
            hintText: hintText,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 14),
          ),
        ),
      ),
    );
  }
}
