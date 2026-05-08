import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/contact_us_container.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactInfoScreen extends StatelessWidget {
  ContactInfoScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchContactInfo();
    });
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
          text: AppString.contactUs,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: AppColors.blue1,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          return RefreshIndicator(
            color: const Color(0xFF233A66),
            backgroundColor: AppColors.appBackgroundColor,
            onRefresh: () async {
              await profileController.fetchContactInfo();
            },
            child: ListView.builder(
              padding: EdgeInsets.only(top: 15.h),
              itemCount: profileController.contactList.length,
              itemBuilder: (context, index) {
                final contact = profileController.contactList[index];
                String rawHtmlDescription = contact['description'] ?? "";
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ContactUsContainer(
                    image: "${ApiEndPoint.imageBaseUrl}${contact['image']}",
                    title: contact['title'] ?? "",
                    subTitle: rawHtmlDescription,
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
