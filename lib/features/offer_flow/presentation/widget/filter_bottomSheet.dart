import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/features/offer_flow/controller/offer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_string/app_string.dart';

class FilterSheet extends StatelessWidget {
  FilterSheet({super.key});
  
  final OfferController controller = Get.find<OfferController>();
  final RxString selectedDistance = "0 - 1 km".obs;

  final List<String> distances = [
    "0 - 1 km",
    "6 - 10 km",
    "11 - 20 km",
    "20+ km",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.blue1,
                  text: AppString.filter,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.blueBase900,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 10.h),
          Divider(height: 25.h, thickness: 1.0, color: AppColors.foundation1),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: CommonText(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.blue1,
              text: AppString.category,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(() {
            if (controller.isLoadingCategories.value) {
              return Padding(
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blue1,
                  ),
                ),
              );
            }

            if (controller.categories.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: CommonText(
                  text: 'No categories available',
                  fontSize: 12,
                  color: AppColors.blueBase,
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(left: 20),
              child: Wrap(
                spacing: 23.w,
                runSpacing: 15.h,
                children: controller.categories
                    .map((cat) => _buildFilterChip(cat.displayName, isCategory: true))
                    .toList(),
              ),
            );
          }),
          SizedBox(height: 12.h),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CommonText(
              fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.distance)
          ),
          SizedBox(height: 12.h),

          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Wrap(
              spacing: 15.w,
              runSpacing: 8.h,
              children: distances
                  .map((dist) => _buildFilterChip(dist, isCategory: false))
                  .toList(),
            ),
          ),
          SizedBox(height: 60.h),
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: CommonButton(text: AppString.applyFilter, onTap: () {
              Get.back();
            },),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {required bool isCategory}) {
    return Obx(() {
      bool isSelected = isCategory
          ? (controller.selectedCategory.value == label)
          : (selectedDistance.value == label);

      return GestureDetector(
        onTap: () {
          if (isCategory) {
            controller.selectCategory(label);
          } else {
            selectedDistance.value = label;
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.blue1.withValues(alpha: 0.15)
                : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? Colors.transparent : AppColors.otpBorderColor,
            ),
          ),
          child: CommonText(
            fontSize: 12.sp,
            color: AppColors.blue1,
            fontWeight: FontWeight.w400,
            text: label,
          ),
        ),
      );
    });
  }
}
