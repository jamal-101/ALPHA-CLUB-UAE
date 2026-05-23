import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/login_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/about_us_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/change_password_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/contact_info_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/faq_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/privacy_policy_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/terms_and_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'delete_account_dialog.dart';
import 'logout_dialog.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuData = [
      {"title": "Contact Us", "icon": Image.asset(AssetPath.contactImage)},
      {
        "title": "Change Password",
        "icon": Image.asset(AssetPath.passwordImage),
      },
      {"title": "FAQ", "icon": Image.asset(AssetPath.faQImage)},
      {"title": "About Us", "icon": Image.asset(AssetPath.aboutUsImage)},
      {
        "title": "Privacy Policy",
        "icon": Image.asset(AssetPath.privacyPolicyImage),
      },
      {
        "title": "Terms & Conditions",
        "icon": Image.asset(AssetPath.termsCondition),
      },
      {"title": "Delete Account", "icon": const Icon(Icons.delete_forever), "color": Colors.red, "isFlutterIcon": true},

      {
        "title": "Logout",
        "icon": Image.asset(AssetPath.logoutImage),
        "color": AppColors.redColor,
      },
    ];

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child:  ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: menuData.length,
            separatorBuilder: (context, index) =>
                Divider(height: 0.5.h, color: AppColors.lineBorderColor),
            itemBuilder: (context, index) {
              final item = menuData[index];
              return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Get.to(() => ContactInfoScreen());
                        break;
                      case 1:
                        Get.to(() => ChangePasswordScreen());
                        break;
                      case 2:
                        Get.to(() => FaqScreen());
                        break;
                      case 3:
                        Get.to(() => AboutUsScreen());
                        break;
                      case 4:
                        Get.to(() => PrivacyPolicyScreen());
                        break;
                      case 5:
                        Get.to(() => TermsAndConditionScreen());
                        break;
                      case 6:
                        Get.dialog(
                          const Dialog(
                            backgroundColor: Colors.transparent,
                            child: DeleteAccountDialog(),
                          ),
                        );
                        break;
                      case 7:
                        Get.dialog(
                          const Dialog(
                            backgroundColor: Colors.transparent,
                            child: LogoutDialog(),
                          ),
                        );
                        break;

                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.sp,
                          width: 20.sp,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              LoginScreen.isAppLied.value
                                  ? Color(0xFF4F6185).withValues(alpha: 0.4)
                                  : item["color"] ?? AppColors.blueBase,
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
                            color: LoginScreen.isAppLied.value
                                ? Color(0xFF4F6185).withValues(alpha: 0.4)
                                : item["color"] ?? AppColors.blueBase,
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
              }
          ),
      );
    }
}
