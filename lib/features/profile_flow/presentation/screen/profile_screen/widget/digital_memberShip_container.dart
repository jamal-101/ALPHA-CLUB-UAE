import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/profile_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_brand_card.dart';
import 'custom_check_list.dart';
import 'member_ship_info_container.dart';


class DigitalMembershipContainer extends StatelessWidget {
  const DigitalMembershipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: RadialGradient(
          center: Alignment.center,
          focal: Alignment.center,
          focalRadius: 0.0,
          radius: 1.9,
          colors: [AppColors.radialGradiant1, AppColors.radialGradiant2],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 46.h,
              width: 46.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue1.withValues(alpha: 0.2),
              ),
              child: Center(
                child: Image.asset(
                  AssetPath.creditCard,
                  fit: BoxFit.contain,
                  height: 25.h,
                  width: 25.w,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.linearGradient1,
                          AppColors.linearGradient2,
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: CommonText(
                    text: AppString.digitalMemberShipCard,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.linearGradient1,
                          AppColors.linearGradient2,
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: CommonText(
                    text: AppString.tapToView,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(width: 70.w),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => modelBottomSheet(context),
                );
              },
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget modelBottomSheet(BuildContext context) {
  return Container(
    height: 850.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.8,
                    colors: [
                      AppColors.radialGradiant1,
                      AppColors.radialGradiant2,
                    ],
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    AssetPath.splashImage,
                    height: 120.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: const Color(0xFF1A2A4D),
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ProfileDataContainer(
            showEditButton: false,
            showBorder: false,
            usePadding: false,
            imagePath: AssetPath.userProfile,
            userName: AppString.userName,
            membershipType: AppString.alphaMember,
            userId: AppString.userId,
          ),
          MemberShipInfoContainer(),
          SizedBox(height: 15.h),
          CommonText(
            style: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            text: AppString.memberShipBenefits,
          ),
          SizedBox(height: 20.h),
          CustomCheckList(),
          SizedBox(height: 24.h),
          Center(
            child: CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.blue1,
              ),
              text: AppString.ourSponsors,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBrandCard(
                imagePath: AssetPath.autoMillennium,
                title: AppString.autoMillennium,
              ),
              CustomBrandCard(
                imagePath: AssetPath.alImage,
                title: AppString.autoMillennium,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBrandCard(
                imagePath: AssetPath.autoMillennium,
                title: AppString.autoMillennium,
              ),
              CustomBrandCard(
                imagePath: AssetPath.alImage,
                title: AppString.autoMillennium,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
