// import 'package:alpha_club/features/auth_flow/controller/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../utils/app_color/app_color.dart';
// import 'commont_text.dart';
//
// class DropDownType extends StatelessWidget {
//   DropDownType({super.key});
//
//   final AuthController authController = Get.put(AuthController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.appBackgroundColor,
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(width: 1.w, color: AppColors.borderColor),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Obx(() => Padding(
//             padding: const EdgeInsets.only(left: 18),
//             child: CommonText(
//               text: authController.selectedMemberType.value,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xFF808080),
//             ),
//           )),
//           PopupMenuButton<MemberType>(
//             color: AppColors.whiteFoundation,
//             icon: const Icon(
//               Icons.keyboard_arrow_down,
//               color: Color(0xFF808080),
//             ),
//             onSelected: (MemberType value) {
//               authController.updateSelectedType(value);
//             },
//             itemBuilder: (context) => [
//               PopupMenuItem(
//                 value: MemberType.alpha,
//                 child: CommonText(
//                   text: "Alpha",
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w400,
//                   color: const Color(0xFF808080),
//                 ),
//               ),
//               PopupMenuItem(
//                 value: MemberType.alphaFamily,
//                 child: CommonText(
//                   text: "Alpha Family",
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w400,
//                   color: const Color(0xFF808080),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import '../../features/profile_flow/controller/profile_controller.dart';
// import '../utils/app_color/app_color.dart';
// import 'commont_text.dart';
//
// class DropDownType extends StatelessWidget {
//   DropDownType({super.key});
//
//   final ProfileController profileController = Get.find<ProfileController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (profileController.isLoading.value && profileController.combinedPlans.isEmpty) {
//         return Container(
//           height: 50.h,
//           alignment: Alignment.center,
//           child: const CircularProgressIndicator(strokeWidth: 2),
//         );
//       }
//
//       return PopupMenuButton<dynamic>(
//         onSelected: (plan) => profileController.updateSelectedPlan(plan),
//         itemBuilder: (context) {
//           return profileController.combinedPlans.map((plan) {
//             return PopupMenuItem<dynamic>(
//               value: plan,
//               child: CommonText(
//                 text: plan['membershipType'] ?? "",
//                 fontSize: 14.sp,
//                 color: Colors.black,
//               ),
//             );
//           }).toList();
//         },
//         child: Container(
//           height: 50.h,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.appBackgroundColor,
//             borderRadius: BorderRadius.circular(8.r),
//             border: Border.all(width: 1.w, color: AppColors.borderColor),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 12),
//                   child: CommonText(
//                     textAlign: TextAlign.start,
//                     text: profileController.selectedMemberType.value,
//                     fontSize: 14.sp,
//                     color: const Color(0xFF808080),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(right: 8.w),
//                 child: Icon(
//                   Icons.keyboard_arrow_down,
//                   color: const Color(0xFF808080),
//                   size: 24.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }



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
                  String formattedName = (plan['membershipType'] ?? "")
                      .toString()
                      .replaceAll('_', ' ')
                      .split(' ')
                      .map((str) => str.capitalizeFirst)
                      .join(' ');
                  return PopupMenuItem<dynamic>(
                    value: plan,
                    child: CommonText(
                      text: formattedName,
                      fontSize: 16.sp,
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