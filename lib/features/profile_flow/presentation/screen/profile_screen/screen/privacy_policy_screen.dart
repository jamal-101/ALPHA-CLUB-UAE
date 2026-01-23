import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../core/global/common_app_bar.dart';
import '../../../../../../core/utils/app_color/app_color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
     PrivacyPolicyScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          color: Color(0xFF233A66),
          backgroundColor: AppColors.appBackgroundColor,
          onRefresh: () async {
            await profileController.privacyPolicy();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  CommonAppBar(title: AppString.privacyPolicy, onTap: () {
                    Get.back();
                  },),
                  SizedBox(height: 16.h),
                  HtmlWidget(
                    profileController.privacyPolicyDescription.value,
                    textStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      ),
    );
  }
}
