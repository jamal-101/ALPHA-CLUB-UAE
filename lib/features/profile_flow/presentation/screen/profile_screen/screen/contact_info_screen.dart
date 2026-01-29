// import 'package:alpha_club/core/global/common_app_bar.dart';
// import 'package:alpha_club/core/utils/app_image/app_image.dart';
// import 'package:alpha_club/core/utils/app_string/app_string.dart';
// import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/widget/contact_us_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
//
// class ContactInfoScreen extends StatelessWidget {
//   const ContactInfoScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: Column(
//           children: [
//             SizedBox(height: 50.h),
//             CommonAppBar(title: AppString.contactUs,onTap: (){
//               Get.back();
//             },),
//             SizedBox(height: 40.h),
//             ContactUsContainer(
//               image: AssetPath.emailIcon,
//               title: AppString.emailAddress,
//               subTitle: AppString.gmail,
//             ),
//             SizedBox(height: 12.h),
//             ContactUsContainer(
//               image: AssetPath.callIcon,
//               title: AppString.contactNumber,
//               subTitle: AppString.userNumber,
//             ),
//             SizedBox(height: 12.h),
//             ContactUsContainer(
//               image: AssetPath.location,
//               title: AppString.locationTitle,
//               subTitle: AppString.location,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:alpha_club/core/global/common_app_bar.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(
              title: AppString.contactUs,
              onTap: () => Get.back(),
            ),
            SizedBox(height: 20.h),

            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  color: Color(0xFF233A66),
                  backgroundColor: AppColors.appBackgroundColor,
                  onRefresh: () async {
                    await profileController.fetchContactInfo();
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: profileController.contactList.length,
                    itemBuilder: (context, index) {
                      final contact = profileController.contactList[index];
                      String cleanDescription = (contact['description'] ?? "")
                          .replaceAll(RegExp(r'<[^>]*>|&nbsp;'), "");

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ContactUsContainer(
                          image: "${ApiEndPoint.imageBaseUrl}${contact['image']}",
                          title: contact['title'] ?? "",
                          subTitle: cleanDescription,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}