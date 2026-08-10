import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/global/common_app_bar.dart';
import '../../../../../../core/global/common_button.dart';
import '../../../../../../core/global/common_text_field.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/global/commont_text_field_email.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: AppColors.appBackgroundColor,
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
          text: AppString.information,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: AppColors.blue1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        height: 100.h,
                        width: 100.w,
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
                                Image.asset(AssetPath.profileIcon, fit: BoxFit.cover),
                          )
                              : Image.asset(AssetPath.profileIcon, fit: BoxFit.cover)),
                        ),
                      );
                    }),

              // ),
                    Positioned(
                      bottom: 2,
                      right: 3,
                      child: GestureDetector(
                        onTap: () => profileController.pickImage(),
                        child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Icon(Icons.camera_alt, size: 18.sp, color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CommonText(text: AppString.fullName, fontSize: 14.sp, color: AppColors.blue1),
              SizedBox(height: 8.h),
              CommonTextFieldEdite(
                controller: profileController.profileNameController,
                hintText: "Enter your name",
                // isPassword: false,
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



class CommonTextFieldEdite extends StatelessWidget {
  const CommonTextFieldEdite({
    super.key,
    this.containerColor = AppColors.fillColor,
    this.borderColor = AppColors.borderColor,
    this.height,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.validator,
    this.isPopins = false,
  });

  final Color containerColor;
  final double? height;
  final Color borderColor;
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isPopins;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontFamily: 'SFPro',
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.blueBase,
      ),

      decoration: InputDecoration(
        filled: true,
        fillColor: containerColor,
        hintText: hintText,
        hintStyle: isPopins ? GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blueBase,
        ) : TextStyle(
            fontFamily: 'SFPro',
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.blueBase
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: borderColor, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: borderColor, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.blueBase, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red, width: 1),
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