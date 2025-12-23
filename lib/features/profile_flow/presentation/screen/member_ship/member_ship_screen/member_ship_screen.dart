import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/custom_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MemberShipScreen extends StatelessWidget {
  const MemberShipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: AppColors.blue1,
              ),
            ),
            SizedBox(height: 12.h),
            CommonText(
              text: AppString.membershipPlans,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.blue1,
            ),
            SizedBox(height: 8.h),
            CommonText(
              textAlign: TextAlign.start,
                text: AppString.chooseThePerfect),
            Expanded(child: CustomTabScreen()),

          ],
        ),
      ),
    );
  }
}
