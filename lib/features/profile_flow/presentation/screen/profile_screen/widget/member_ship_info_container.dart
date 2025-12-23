import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberShipInfoContainer extends StatelessWidget {
  const MemberShipInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.otpBorderColor,
        ),
      ),child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
        children: [
          _infoRow(AppString.memberID, AppString.userId),
          SizedBox(height: 10.h),
          _infoRow(AppString.memberShipType, AppString.family),
          SizedBox(height: 10.h),
          _infoRow(AppString.memberSince, AppString.month),
          SizedBox(height: 10.h),
          _infoRow(AppString.expires, AppString.year),
        ],
            ),
      ),
    );
  }
}


Widget _infoRow(String title, String value) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 14.sp,
            color: AppColors.blue1,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
     CommonText(
         text: " : ",
       fontWeight: FontWeight.w400,
       fontSize: 14,
       color: AppColors.blue1,
     ),
      Expanded(
        flex: 3,
        child: Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 14.sp,
            color: AppColors.blue1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}