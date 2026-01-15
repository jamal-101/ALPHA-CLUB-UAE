import 'package:alpha_club/features/auth_flow/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/app_color/app_color.dart';
import 'commont_text.dart';

class DropDownType extends StatelessWidget {
  DropDownType({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1.w, color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Padding(
            padding: const EdgeInsets.only(left: 18),
            child: CommonText(
              text: authController.selectedMemberType.value,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF808080),
            ),
          )),
          PopupMenuButton<MemberType>(
            color: AppColors.whiteFoundation,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF808080),
            ),
            onSelected: (MemberType value) {
              authController.updateSelectedType(value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: MemberType.alpha,
                child: CommonText(
                  text: "Alpha",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF808080),
                ),
              ),
              PopupMenuItem(
                value: MemberType.alphaFamily,
                child: CommonText(
                  text: "Alpha Family",
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