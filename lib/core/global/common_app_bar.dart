import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CommonAppBar({super.key, required this.title,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
            child: Icon(Icons.arrow_back_ios_new_rounded,size: 18,color: AppColors.blue1,)),
        CommonText(
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: AppColors.blue1,
          ),
            text: title,
        ),
        SizedBox(),
      ],
    );
  }
}
