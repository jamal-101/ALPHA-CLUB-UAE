import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomCheckList extends StatelessWidget {
  CustomCheckList({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.isLoading.value && profileController.alphaFamilyLanList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final List items = profileController.alphaFamilyLanList['features'] ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child:_buildCustomItem(item['title']?.toString() ?? ""),
          );
        }).toList(),
      );
    });
  }

  Widget _buildCustomItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Image.asset(
            AssetPath.checkIcon,
            color: AppColors.blue1,
            height: 12.h,
            width: 12.w,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [AppColors.linearGradient1, AppColors.linearGradient2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: CommonText(
              maxLines: 1,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: Colors.white,
              text: text,
            ),
          ),
        ),
      ],
    );
  }
}
