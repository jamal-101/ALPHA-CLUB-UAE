import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/comparison_list.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/family_memberShip.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/regular_member_ship_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_string/app_string.dart';
import 'comparison_button.dart';


class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            RegularMemberShipWidget(),
            SizedBox(height: 16.h),
             FamilyMembership(),
            SizedBox(height: 16.h),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blue1,
              ),
              text: AppString.featureComparison,
            ),
            SizedBox(height: 16.h),
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