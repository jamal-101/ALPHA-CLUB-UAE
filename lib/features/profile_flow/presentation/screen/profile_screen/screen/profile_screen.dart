import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/custom_list_view.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/digital_memberShip_container.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/profile_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../../../core/route/app_route.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(

            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoute.personalInformation);
                  },
                  child: ProfileDataContainer(
                    imagePath: AssetPath.userProfile, userName: AppString.userName,
                    membershipType: AppString.alphaMember, userId: AppString.userId,
                  ),
                ),
                SizedBox(height: 16.h),
                DigitalMembershipContainer(),
                SizedBox(height: 16.h),
                CommonText(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'SFPro',
                  ),
                  color: AppColors.blue1,
                  text: AppString.memberShip,
                ),
                SizedBox(height: 16.h),
                memberShipContainer(),
                SizedBox(height: 16.h),
                CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                    color: AppColors.blue1,
                    text: AppString.setting
                ),
                SizedBox(height: 16.h),
                CustomListView()
              ],
            ),
          ),
          CommonBottomNabVar(selectedIndex: 0),
        ],
      ),
    );
  }
}


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> MemberShipContainer <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

Widget memberShipContainer (){
  return Container(
    height: 44.h,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        width: 1.w,
        color: AppColors.otpBorderColor,
      ),
      color: Colors.white,
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 13,right: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                AssetPath.memberShipCard,
                fit: BoxFit.contain,
                height: 25,
                width: 25,
              ),
              SizedBox(width: 10.w),
              CommonText(
                text: AppString.memberShipPlan,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blueBase,
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoute.memberShipScreen);
            },
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.blueBase,
              size: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
