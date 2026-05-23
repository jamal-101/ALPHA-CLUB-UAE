// import 'package:alpha_club/core/global/common_app_bar.dart';
// import 'package:alpha_club/core/utils/app_string/app_string.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
//
// import '../../../../core/global/common_button.dart';
// import '../../../../core/global/common_text_field.dart';
// import '../../../../core/global/commont_text.dart';
// import '../../../../core/global/message_field.dart';
// import '../../../../core/route/app_route.dart';
// import '../../../../core/utils/app_color/app_color.dart';
//
// class EventRegisterScreen extends StatelessWidget {
//       EventRegisterScreen({super.key});
//
//   final TextEditingController textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20,right: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonAppBar(title: AppString.eventRegister,onTap: (){
//                 Get.toNamed(AppRoute.eventScreen);
//               },),
//               SizedBox(height: 100.h),
//               CommonText(
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.blue1,
//                     fontFamily: 'SFPro'
//                 ),
//                 text: AppString.email,
//               ),
//               SizedBox(height: 12.h),
//               CommonTextField(
//                 hintText: AppString.enterEmailAddress,
//               ),
//               SizedBox(height: 24.h),
//               CommonText(
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.blue1,
//                     fontFamily: 'SFPro'
//                 ),
//                 text: AppString.message,
//               ),
//               SizedBox(height: 12.h),
//               MessageField(
//                 fillColor: AppColors.fillColor,
//                 containerColor: AppColors.fillColor,
//                   textController: textController),
//               SizedBox(height: 30.h),
//               CommonButton(onTap: (){
//                 Get.toNamed(AppRoute.eventScreen);
//               }, text: AppString.register),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
