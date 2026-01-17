import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/global/custom_search_bar.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/clubs/presentation/widget/discover_club.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';


class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonBottomNabVar(selectedIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue1,
                    text: AppString.discoverClubs),
                SizedBox(height: 4.h),
                CommonText(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueBase,
                    text: AppString.findYOur),
                SizedBox(height: 16.h),
                CustomSearchField(),
                SizedBox(height: 16.h),
                DiscoverClub(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
