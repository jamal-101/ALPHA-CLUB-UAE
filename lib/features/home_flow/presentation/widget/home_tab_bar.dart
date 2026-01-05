import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/features/home_flow/presentation/widget/sponsor_widget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'latast_stories_list_screen.dart';

class HomeTabBar extends StatelessWidget {
  HomeTabBar({super.key});

  final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            height: 40.h,
            child: TabBar(
              onTap: (index) {
                currentIndex.value = index;
              },
              labelPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 12.w),
      
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColors.tabContainerColor,
                border: Border.all(
                  width: 1,
                  color: AppColors.tabSelectedBorderColor,
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF7A869A),
              labelStyle: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
      
              tabs: [
                _buildTabItem(0, AssetPath.tabIcon1, "Latest Stories"),
                _buildTabItem(1, AssetPath.tabIcon2, "Sponsors"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                NewsListView(),
                SponsorWidgetScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, dynamic icon, String label) {
    return Obx(() {
      bool isSelected = currentIndex.value == index;
      return Tab(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          alignment: Alignment.center,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : AppColors.tabUnselectBorderColor,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                color: isSelected
                    ? AppColors.goldColor1
                    : AppColors.tabUnselectBorderColor,
                height: 18.sp,
                width: 18.sp,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: CommonText(
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: isSelected
                        ? AppColors.borderColor
                        : AppColors.tabUnselectBorderColor,
                  ),
                  text: label,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
