import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_string/app_string.dart';

class SavFamilyMembers extends StatelessWidget {
  final String name;
  final String email;
  final String relation;
  final VoidCallback onDelete;

  const SavFamilyMembers({
    super.key,
    required this.name,
    required this.email,
    required this.relation,
    required this.onDelete,
  });

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
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            GestureDetector(
              onTap: onDelete,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Icon(Icons.delete, color: AppColors.redColor, size: 18.sp),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            _infoRow(AppString.fullName, name),
            SizedBox(height: 10.h),
            _infoRow(AppString.email, email),
            SizedBox(height: 10.h),
            _infoRow("Relationship", relation),
          ],
        ),
          // ],
        ),
      // ),
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

