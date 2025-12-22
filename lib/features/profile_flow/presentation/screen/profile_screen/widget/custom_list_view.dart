import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuData = [
      {"title": "Contact Us", "icon": Image.asset(AssetPath.contactImage)},
      {"title": "Change Password", "icon": Image.asset(AssetPath.passwordImage)},
      {"title": "FAQ", "icon": Image.asset(AssetPath.faQImage)},
      {"title": "About Us", "icon": Image.asset(AssetPath.aboutUsImage)},
      {"title": "Privacy Policy", "icon": Image.asset(AssetPath.privacyPolicyImage)},
      {"title": "Terms & Conditions", "icon": Image.asset(AssetPath.termsCondition)},
      {"title": "Logout", "icon": Image.asset(AssetPath.logoutImage), "color": AppColors.redColor},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: menuData.length,
        separatorBuilder: (context, index) => Divider(
          height: 0.5.h,
          color: AppColors.lineBorderColor,
        ),
          itemBuilder: (context, index) {
            final item = menuData[index];
            return GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.sp,
                      width: 20.sp,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          item["color"] ?? AppColors.blueBase,
                          BlendMode.srcIn,
                        ),
                        child: item["icon"],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: CommonText(
                        textAlign: TextAlign.start,
                        text: item["title"],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: item["color"] ?? AppColors.blueBase,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14.sp,
                      color: item["color"] != null
                          ? AppColors.foundation1
                          : AppColors.blueBase,
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}