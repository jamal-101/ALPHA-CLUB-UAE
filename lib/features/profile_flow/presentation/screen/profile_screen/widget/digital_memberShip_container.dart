import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/login_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/profile_data_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'custom_check_list.dart';
import 'member_ship_info_container.dart';


class DigitalMembershipContainer extends StatelessWidget {
  const DigitalMembershipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 88.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LoginScreen.isAppLied.value ?
          RadialGradient(
            center: Alignment.center,
            focal: Alignment.center,
            focalRadius: 0.0,
            radius: 1.9,
            colors: [Color(0xFF9DA1AA), Color(0xFF9DA1AA)],
            stops: const [0.0, 1.0],
          ):
          RadialGradient(
            center: Alignment.center,
            focal: Alignment.center,
            focalRadius: 0.0,
            radius: 1.9,
            colors: [AppColors.radialGradiant1, AppColors.radialGradiant2],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Flexible(
                child: Column(
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {
                  LoginScreen.isAppLied.value ? null :
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => modelBottomSheet(context),
                  );
                },
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: LoginScreen.isAppLied.value ? Colors.white54 : Colors.white,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
  }
}

Widget modelBottomSheet(BuildContext context) {
  return Container(
    height: 550.h,
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
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            text: AppString.memberShipBenefits,
          ),
          SizedBox(height: 20.h),
          CustomCheckList(),
          SizedBox(height: 20.h),
        ],
      ),
    ),
  );
}
