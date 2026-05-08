import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import '../../features/profile_flow/controller/profile_controller.dart';
import '../utils/app_color/app_color.dart';
import 'commont_text.dart';

class DropDownType extends StatelessWidget {
  DropDownType({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      Container(
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child:  CommonText(
                  textAlign: TextAlign.start,
                  text: profileController.selectedMemberType.value,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF808080),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
              ),
             PopupMenuButton<dynamic>(
              offset: Offset(0, 40.h),
              surfaceTintColor: Colors.white,
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF808080),
              ),
              onSelected: (plan) {
                profileController.updateSelectedPlan(plan);
              },
              itemBuilder: (context) {

                if (profileController.combinedPlans.isEmpty) {
                  return [
                    const PopupMenuItem(
                      enabled: false,
                      child: Text("No plans available"),
                    )
                  ];
                }

                return profileController.combinedPlans.map((plan) {
                  String formattedName = (plan['title'] ?? "")
                      .toString()
                      .replaceAll('_', ' ')
                      .split(' ')
                      .map((str) => str.capitalizeFirst)
                      .join(' ');
                  return PopupMenuItem<dynamic>(
                    value: plan,
                    child: CommonText(
                      text: formattedName,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF808080),
                    ),
                  );
                }).toList();
              },
            )
          ],
        ),
      ),
    );
  }
}