// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CommonTextField extends StatelessWidget {
//
//
//   const CommonTextField({
//     super.key,
//     this.containerColor = AppColors.fillColor,
//     this.borderColor = AppColors.borderColor,
//     this.height,
//     this.hintText,
//     this.prefixIcon,
//     this.isPassword = false,
//     this.controller,
//     this.onChanged,
//     this.validator,
//     this.isPopins = false,
//   });
//
//   final Color containerColor;
//   final double? height;
//   final Color borderColor;
//   final String? hintText;
//   final Widget? prefixIcon;
//   final TextEditingController? controller;
//   final bool isPassword;
//   final Function(String)? onChanged;
//   final String? Function(String?)? validator;
//   final bool isPopins;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     RxBool isVisible = false.obs;
//
//     return Obx(()=>
//       Container(
//         height: height?.h ?? 50.h,
//         decoration: BoxDecoration(
//           color: containerColor,
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(width: 1.w, color: borderColor),
//         ),
//         child: TextFormField(
//           controller: controller,
//           onChanged: onChanged,
//           validator: validator,
//           style: TextStyle(
//               fontFamily: 'SFPro',
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.blueBase
//           ),
//           obscureText: isVisible.value,
//           decoration: InputDecoration(
//             hintStyle: isPopins ? GoogleFonts.poppins(
//               fontWeight: FontWeight.w400,
//               fontSize: 14.sp,
//               color: AppColors.blueBase,
//             ) : TextStyle(
//               fontFamily: 'SFPro',
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.blueBase
//             ),
//             prefixIconConstraints: BoxConstraints(
//               minWidth: 25.w,
//               maxHeight: 50.h,
//             ),
//             prefixIcon: prefixIcon != null
//                 ? Padding(
//               padding: EdgeInsets.only(left: 13.w,right: 2),
//               child: prefixIcon,
//             )
//                 : null,
//             suffixIcon: isPassword
//                 ? InkWell(
//               onTap: () => isVisible.value = !isVisible.value,
//               child: Icon(
//                 isVisible.value
//                     ? Icons.visibility_off_outlined
//                     : Icons.visibility_outlined,
//                 color: const Color(0xFF808080),
//               ),
//             ) : null,
//             hintText: hintText,
//             border: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 14),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_color/app_color.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.containerColor = AppColors.fillColor,
    this.borderColor = AppColors.borderColor,
    this.height,
    this.hintText,
    this.prefixIcon,
    this.isPassword = true,
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
  final bool isPassword;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isPopins;

  @override
  Widget build(BuildContext context) {
    RxBool isVisible = true.obs;

    return Obx(()=>
       TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
          // obscureText: isPassword ? isVisible.value : false,
         obscureText: isVisible.value,
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
            prefixIconConstraints: BoxConstraints(
                minWidth: 25.w,
                maxHeight: 50.h,
              ),
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
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: prefixIcon,
                  )
                : null,
             suffixIcon: isPassword
                ? Obx(()=>
                  InkWell(
                      onTap: () => isVisible.value = !isVisible.value,
                      child: Icon(
                        isVisible.value
                            ?  Icons.visibility_off_outlined : Icons.visibility_outlined ,
                        color: const Color(0xFF808080),
                      ),
                    ),
                )
                : null,
          ),
      ),
    );
  }
}
