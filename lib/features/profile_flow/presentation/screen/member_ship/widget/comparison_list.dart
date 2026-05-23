import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';
import '../../../../controller/profile_controller.dart';

class ComparisonList extends StatelessWidget {
  const ComparisonList({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Obx(() {
      // if (controller.isLoading.value) {
      //   return const Center(child: CircularProgressIndicator());
      // }

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.comparisonList.length,
        itemBuilder: (context, index) {
          final item = controller.comparisonList[index];

          return Container(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1))
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    item['feature'] ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: (item['alpha'] == true)
                        ? Image.asset(AssetPath.checkIcon, height: 14.sp, width: 14.sp, color: AppColors.green1)
                        : Icon(Icons.close, color: AppColors.foundationWhite1, size: 18.sp),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: (item['alpha_family'] == true)
                        ? Image.asset(AssetPath.checkIcon, height: 14.sp, width: 14.sp, color: AppColors.green1)
                        : Icon(Icons.close, color: AppColors.foundationWhite1, size: 18.sp),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}