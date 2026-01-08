import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';


class AlphaFamilyWidget extends StatelessWidget {
     AlphaFamilyWidget({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    final alphaFamilyData = profileController.alphaFamilyLanList;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.goldColor1.withValues(alpha: 0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        "${ApiEndPoint.imageBaseUrl}${alphaFamilyData['logo'] ?? ""}",
                        height: 25.h,
                        width: 25.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        color: AppColors.blue1,
                        text: alphaFamilyData['title'] ?? "No Title",
                      ),
                      CommonText(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        color: AppColors.blueBase,
                        text: alphaFamilyData['description'] ?? "No Description",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CommonText(
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.blueBase,
              ),
              text: alphaFamilyData['subDescription'] ?? "No Sub-description",
            ),
          ],
        ),
      ),
    );
  }
}
