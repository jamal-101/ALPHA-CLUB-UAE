import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/alpha/screen/alpha_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../family/screen/alfha_family_screen.dart';
import '../comparison/screen/comparison_screen.dart';

class CustomTabScreen extends StatelessWidget {
  const CustomTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _buildTabbarHeader(),
           Expanded(
            child: TabBarView(
              children: [
                ComparisonScreen(),
                AlphaScreen(),
                FamilyScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabbarHeader() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        TabBar(
          labelPadding: EdgeInsets.only(right: 2.w),
          dividerColor: Colors.transparent,
          labelColor: AppColors.blue1,
          unselectedLabelColor: AppColors.foundationWhite,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 6.h,
              color: AppColors.blueLiner2,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            // fontFamily: 'SFPro',
          ),
          tabs: [
            Tab(text: AppString.comparison),
            Tab(text: AppString.alpha),
            Tab(text: AppString.alphaFamily),
          ],
        ),
      ],
    );
  }
}


//>>>>>>>>>>>>>>>>>>>>>> Indicator linearGradient Color <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//



