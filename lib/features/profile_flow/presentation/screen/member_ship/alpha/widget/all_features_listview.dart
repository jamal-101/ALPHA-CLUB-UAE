import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../../../core/global/commont_text.dart';
import '../../../../../../../core/service/api/api_enpoint.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../../core/utils/app_image/app_image.dart';
import '../../../../../controller/profile_controller.dart';

class AllFeaturesListview extends StatelessWidget {
  const AllFeaturesListview({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Obx(() {
      if (profileController.alphaPlanList.isEmpty){
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      final List features = profileController.alphaPlanList['features'];

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final item = features[index];

          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.otpBorderColor, width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.goldColor1.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Image.network(
                    "${ApiEndPoint.imageBaseUrl}${item['icon'] ?? ""}",
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.star, color: AppColors.goldColor1),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue1,
                        ),
                        text: item['title'] ?? "",
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blueBase,
                        ),
                        text: item['description'] ?? "",
                      )
                    ],
                  ),
                ),
                Image.asset(
                  AssetPath.checkIcon,
                  color: AppColors.green1,
                  height: 16.h,
                  width: 16.w,
                )
              ],
            ),
          );
        },
      );
    });
  }
}