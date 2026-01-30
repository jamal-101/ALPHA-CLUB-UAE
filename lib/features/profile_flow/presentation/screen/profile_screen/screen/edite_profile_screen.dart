import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../../core/global/common_app_bar.dart';
import '../../../../../../core/global/common_button.dart';
import '../../../../../../core/global/common_text_field.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';
import '../../../../../../core/utils/app_string/app_string.dart';
import '../../../../controller/profile_controller.dart';

class EditeProfileScreen extends StatelessWidget {
  EditeProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              CommonAppBar(
                title: AppString.information,
                onTap: () => Get.back(),
              ),
              SizedBox(height: 30.h),

              Center(
                child: Stack(
                  children: [
                    // Obx(() {
                    //   final profile = profileController.membershipData;
                    //   final String? remoteImage = profile['profileImage'];
                    //   final String fullRemotePath = (remoteImage != null &&
                    //       remoteImage.isNotEmpty)
                    //       ? (remoteImage.startsWith('http')
                    //       ? remoteImage
                    //       : "${ApiEndPoint.imageBaseUrl}$remoteImage")
                    //       : "";
                    //   return Container(
                    //     height: 80.h,
                    //     width: 80.w,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(
                    //         width: 3.w,
                    //         color: AppColors.profileBorderColor,
                    //       ),
                    //     ),
                    //     child: ClipOval(
                    //       child: profileController.selectedImage.value != null
                    //           ? Image.file(profileController.selectedImage.value!, fit: BoxFit.cover) // গ্যালারি থেকে নতুন ইমেজ
                    //           : (fullRemotePath.isNotEmpty
                    //           ? Image.network(
                    //         "$fullRemotePath?v=${DateTime.now().millisecondsSinceEpoch}", // সার্ভারে থাকা আগের ইমেজ
                    //         fit: BoxFit.cover,
                    //         errorBuilder: (context, error, stackTrace) =>
                    //             Image.asset(AssetPath.informationImage, fit: BoxFit.cover),
                    //       )
                    //           : Image.asset(AssetPath.informationImage, fit: BoxFit.cover)), // ডিফল্ট ইমেজ
                    //     ),
                    //     // ClipOval(
                    //     //   child: profileController.selectedImage.value != null
                    //     //       ? Image.file(
                    //     //       profileController.selectedImage.value!,
                    //     //       fit: BoxFit.cover)
                    //     //       : Image.asset(
                    //     //       AssetPath.informationImage, fit: BoxFit.cover),
                    //     // ),
                    //   );
                    // }


                    Obx(() {
                      final profile = profileController.membershipData;
                      final String? remoteImage = profile['profileImage'];

                      final String fullRemotePath = (remoteImage != null && remoteImage.isNotEmpty)
                          ? (remoteImage.startsWith('http')
                          ? remoteImage
                          : "${ApiEndPoint.imageBaseUrl}$remoteImage")
                          : "";

                      return Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3.w,
                            color: AppColors.profileBorderColor,
                          ),
                        ),
                        child: ClipOval(
                          child: profileController.selectedImage.value != null
                              ? Image.file(profileController.selectedImage.value!, fit: BoxFit.cover)
                              : (fullRemotePath.isNotEmpty
                              ? Image.network(
                            "$fullRemotePath?v=${DateTime.now().millisecondsSinceEpoch}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(AssetPath.informationImage, fit: BoxFit.cover),
                          )
                              : Image.asset(AssetPath.informationImage, fit: BoxFit.cover)),
                        ),
                      );
                    }),

              // ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: GestureDetector(
                        onTap: () => profileController.pickImage(),
                        child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Icon(Icons.camera_alt, size: 12.sp, color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CommonText(text: AppString.fullName, fontSize: 14.sp, color: AppColors.blue1),
              SizedBox(height: 8.h),
              CommonTextField(
                controller: profileController.profileNameController,
                hintText: "Enter your name",
              ),
              SizedBox(height: 50.h),
              // Obx(() =>
              // profileController.isLoading.value
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              CommonButton(
                onTap: () => profileController.updateProfile(),
                text: "Profile Update request",
              )
        // ),
            ],
          ),
        ),
      ),
    );
  }
}




// SizedBox(height: 16.h),
// CommonText(
//     style: TextStyle(
//       fontFamily: 'SFPro',
//       fontWeight: FontWeight.w500,
//       fontSize: 14,
//       color: AppColors.blue1,
//     ),
//     text: AppString.email
// ),
// SizedBox(height: 8.h),
// CommonTextField(
//   isPopins: true,
//   containerColor: AppColors.appBackgroundColor,
//   hintText: AppString.gmail,
// ),
// CommonText(
//     style: TextStyle(
//       fontFamily: 'SFPro',
//       fontWeight: FontWeight.w500,
//       fontSize: 14,
//       color: AppColors.blue1,
//     ),
//     text: AppString.contactNumber
// ),
// SizedBox(height: 8.h),
// CustomPhoneField(
//   hintText: "09 -1897243189",
//   onNumberChanged: (phone) {
//     debugPrint("Full Number: ${phone.completeNumber}");
//     profileController.phoneNumber.value = phone.completeNumber;
//   },
// ),
// SizedBox(height: 16.h),
// CommonText(
//     style: TextStyle(
//       fontFamily: 'SFPro',
//       fontWeight: FontWeight.w500,
//       fontSize: 14,
//       color: AppColors.blue1,
//     ),
//     text: AppString.address
// ),
// SizedBox(height: 8.h),
// CommonTextField(
//   isPopins: true,
//   containerColor: AppColors.appBackgroundColor,
//   hintText: AppString.location,
// ),