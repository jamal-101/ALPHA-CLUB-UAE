import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MembershipInfoCard extends StatelessWidget {
  const MembershipInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1.w,
          color: const Color(0xFFE8E9EA),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoRow("Member ID", "AC-2024-5871"),
            SizedBox(height: 12.h),
            _buildInfoRow("Membership Type", "Family"),
            SizedBox(height: 12.h),
            _buildInfoRow("Member Since", "March 2024"),
            SizedBox(height: 12.h),
            _buildInfoRow("Expires", "December 31, 2025"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 14.sp,
              color: const Color(0xFF1A2A4D),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(":", style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1A2A4D))),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 14.sp,
              color: const Color(0xFF1A2A4D),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}