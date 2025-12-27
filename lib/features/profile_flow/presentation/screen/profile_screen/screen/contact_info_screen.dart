import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/contact_us_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(title: AppString.contactUs,onTap: (){
              Get.back();
            },),
            SizedBox(height: 40.h),
            ContactUsContainer(
              image: AssetPath.emailIcon,
              title: AppString.emailAddress,
              subTitle: AppString.gmail,
            ),
            SizedBox(height: 12.h),
            ContactUsContainer(
              image: AssetPath.callIcon,
              title: AppString.contactNumber,
              subTitle: AppString.userNumber,
            ),
            SizedBox(height: 12.h),
            ContactUsContainer(
              image: AssetPath.location,
              title: AppString.locationTitle,
              subTitle: AppString.location,
            ),
          ],
        ),
      ),
    );
  }
}
