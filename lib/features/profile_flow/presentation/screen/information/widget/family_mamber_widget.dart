import 'package:alpha_club/core/global/drop_down_status.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../../../../core/global/common_text_field.dart';
import '../../../../../../core/utils/app_color/app_color.dart';

class FamilyMemberWidget extends StatelessWidget {
      FamilyMemberWidget({super.key});


  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          isPopins: false,
          containerColor: AppColors.appBackgroundColor,
          controller: profileController.familyNameController,
          hintText: AppString.enterFullName,
        ),
        SizedBox(height: 12.h),
        CommonTextField(
          isPopins: false,
          containerColor: AppColors.appBackgroundColor,
          controller: profileController.familyEmailController,
          hintText: AppString.enterEmail,
        ),
        SizedBox(height: 12.h),
        DropDownStatus()
      ],
    );
  }
}
