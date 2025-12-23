import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/comparison_list.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/family_memberShip.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/regular_member_ship_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'comparison_button.dart';


class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            RegularMemberShipWidget(),
            SizedBox(height: 16.h),
            FamilyMembership(),
            SizedBox(height: 10.h),
            ComparisonButton(),
            SizedBox(height: 12.h),
            ComparisonList(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}