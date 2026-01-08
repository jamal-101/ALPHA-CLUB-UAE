import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'commont_text.dart';


class DropDownStatus extends StatelessWidget {
  DropDownStatus({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1.w, color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CommonText(
                text: profileController.selectedGender.value,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080),
              ),
            ),
          ),
          PopupMenuButton<Gender>(
            color: AppColors.appBackgroundColor,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF808080),
            ),
            onSelected: (Gender value) {
              profileController.updateSelectedGender(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Gender.name,
                child: CommonText(
                  text: "spouse",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF808080),
                ),
              ),
              PopupMenuItem(
                value: Gender.email,
                child: CommonText(
                  text: "child",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF808080),
                ),
              ),
              PopupMenuItem(value: Gender.relation,
                child: CommonText(
                  text: "daughter",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF808080),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
