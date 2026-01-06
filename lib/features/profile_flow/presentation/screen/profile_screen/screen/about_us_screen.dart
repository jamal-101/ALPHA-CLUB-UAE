import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';


class AboutUsScreen extends StatelessWidget {
     AboutUsScreen({super.key});


  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                CommonAppBar(title: AppString.aboutUs, onTap: () {
                  Get.back();
                },),
                SizedBox(height: 20.h),
                HtmlWidget(
                  profileController.aboutDescription.value,
                  textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueBase
                  ),
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
