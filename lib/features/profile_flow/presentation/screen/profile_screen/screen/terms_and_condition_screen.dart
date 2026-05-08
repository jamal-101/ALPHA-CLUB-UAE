import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../../../../core/global/commont_text.dart';

class TermsAndConditionScreen extends StatelessWidget {
  TermsAndConditionScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.appBackgroundColor,
        centerTitle: true,
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blue1,
            size: 20.sp,
          ),
        ),
        title: CommonText(
          text: AppString.termsAndCondition,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: AppColors.blue1,
          ),
        ),
      ),
      body: Obx(() {
        return RefreshIndicator(
          color: Color(0xFF233A66),
          backgroundColor: AppColors.appBackgroundColor,
          onRefresh: () async {
            await profileController.termsAndCondition();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  HtmlWidget(
                    profileController.termsDescription.value,
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueBase,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
