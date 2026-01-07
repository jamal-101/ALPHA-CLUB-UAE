import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';
import '../../../../controller/profile_controller.dart';

class RegularMemberShipWidget extends StatelessWidget {
  final Map<String, dynamic> planData;

  const RegularMemberShipWidget({super.key, required this.planData});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    final List features = planData['features'] ?? [];
    final String planId = planData['_id'] ?? "";

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1.w, color: AppColors.otpBorderColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue1.withValues(alpha: 0.2),
                  ),
                  child: Image.network(
                    "${ApiEndPoint.imageBaseUrl}${planData['logo'] ?? ""}",
                    height: 30.h,
                    width: 30.w,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.card_membership, color: AppColors.blue1, size: 24.sp),
                  ),
                ),
                SizedBox(width : 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue1,
                        text: planData['title'] ?? "",
                      ),
                      CommonText(
                        maxLines: 10,
                        textAlign: TextAlign.start,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blue1.withValues(alpha: 0.7),
                        text: planData['description'] ?? "",
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            CommonText(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.goldColor1,
              text: "KEY BENEFITS",
            ),
            SizedBox(height: 8.h),
            Obx(() {
              bool isExpanded = profileController.expandedStates[planId] ?? false;
              int displayCount = isExpanded
                  ? features.length
                  : (features.length > 4 ? 4 : features.length);
              int moreCount = features.length - 4;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          children: [
                            Image.asset(AssetPath.checkIcon, height: 16.h, width: 16.w),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: CommonText(
                                textAlign: TextAlign.start,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blue1,
                                text: features[index]['title'] ?? "",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (features.length > 4)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: GestureDetector(
                        onTap: () => profileController.toggleExpansion(planId),
                        child: Row(
                          children: [
                            CommonText(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.green1,
                              text: isExpanded
                                  ? "Show Less"
                                  : "+ $moreCount more features",
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColors.green1,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
