// import 'package:alpha_club/core/global/common_button.dart';
// import 'package:alpha_club/features/offer_flow/controller/offer_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../core/global/commont_text.dart';
// import '../../../../core/utils/app_color/app_color.dart';
// import '../../../../core/utils/app_string/app_string.dart';
//
// class FilterSheet extends StatelessWidget {
//   FilterSheet({super.key});
//
//   final OfferController controller = Get.find<OfferController>();
//   final RxString selectedDistance = "0 - 1 km".obs;
//
//   final List<String> distances = [
//     "0 - 1 km",
//     "6 - 10 km",
//     "11 - 20 km",
//     "20+ km",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CommonText(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   color: AppColors.blue1,
//                   text: AppString.filter,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Icon(
//                     Icons.close,
//                     color: AppColors.blueBase900,
//                     size: 18,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // SizedBox(height: 10.h),
//           Divider(height: 25.h, thickness: 1.0, color: AppColors.foundation1),
//           Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: CommonText(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: AppColors.blue1,
//               text: AppString.category,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Obx(() {
//             if (controller.isLoadingCategories.value) {
//               return Padding(
//                 padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.blue1,
//                   ),
//                 ),
//               );
//             }
//
//             if (controller.categories.isEmpty) {
//               return Padding(
//                 padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
//                 child: CommonText(
//                   text: 'No categories available',
//                   fontSize: 12,
//                   color: AppColors.blueBase,
//                 ),
//               );
//             }
//
//             return Padding(
//               padding: EdgeInsets.only(left: 20),
//               child:
//               // Wrap(
//               //   spacing: 23.w,
//               //   runSpacing: 15.h,
//               //   children: controller.categories
//               //       .map((cat) => _buildFilterChip(cat.displayName, isCategory: true))
//               //       .toList(),
//               // ),
//               Wrap(
//                 spacing: 23.w,
//                 runSpacing: 15.h,
//                 children: controller.categories
//                     .map((cat) => _buildFilterChip(
//                     cat.name,
//                     id: cat.id,
//                     isCategory: true))
//                     .toList(),
//               )
//             );
//           }),
//           SizedBox(height: 12.h),
//           Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: CommonText(
//               fontWeight: FontWeight.w400,
//                 fontSize: 14,
//                 color: AppColors.blue1,
//                 text: AppString.distance)
//           ),
//           SizedBox(height: 12.h),
//
//           Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: Wrap(
//               spacing: 15.w,
//               runSpacing: 8.h,
//               children: distances
//                   .map((dist) => _buildFilterChip(dist, isCategory: false))
//                   .toList(),
//             ),
//           ),
//           SizedBox(height: 60.h),
//           Padding(
//             padding: EdgeInsets.only(left: 20,right: 20),
//             child: CommonButton(text: AppString.applyFilter, onTap: () {
//               controller.applyCategoryFilter();
//             },),
//           ),
//           SizedBox(height: 50.h),
//         ],
//       ),
//     );
//   }
//
//
//   // Widget _buildFilterChip(String label, {String? id, required bool isCategory}) {
//   //   if (isCategory) {
//   //     return Obx(() {
//   //       bool isSelected = controller.tempSelectedCategoryId.value == id;
//   //
//   //       return GestureDetector(
//   //         onTap: () => controller.selectCategory(id ?? ""),
//   //         child: _chipContainer(label, isSelected),
//   //       );
//   //     });
//   //   }
//   //   return _chipContainer(label, false);
//   // }
//   Widget _buildFilterChip(String label, {String? id, required bool isCategory}) {
//     if (isCategory) {
//       return Obx(() {
//         bool isSelected = controller.tempSelectedCategoryId.value == id;
//
//         return GestureDetector(
//           onTap: () {
//             controller.tempSelectedCategoryId.value = id ?? "";
//           },
//           child: _chipContainer(label, isSelected),
//         );
//       });
//     }
//     return _chipContainer(label, false);
//   }
//   Widget _chipContainer(String label, bool isSelected) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: isSelected ? AppColors.blue1.withValues(alpha: 0.15) : Colors.transparent,
//         borderRadius: BorderRadius.circular(10.r),
//         border: Border.all(
//           color: isSelected ? Colors.transparent : AppColors.otpBorderColor,
//         ),
//       ),
//       child: CommonText(
//         fontSize: 12.sp,
//         color: AppColors.blue1,
//         fontWeight: FontWeight.w400,
//         text: label,
//       ),
//     );
//   }
//   }
//


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

  final List<Map<String, String>> distanceOptions = [
    {"label": "0 - 1 km", "min": "0", "max": "1"},
    {"label": "6 - 10 km", "min": "6", "max": "10"},
    {"label": "11 - 20 km", "min": "11", "max": "20"},
    {"label": "20+ km", "min": "20", "max": "100"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header অংশ
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
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: AppColors.blueBase900, size: 18),
                  ),
                ],
              ),
            ),
            Divider(height: 25.h, thickness: 1.0, color: AppColors.foundation1),
        
            // Category সেকশন
            Padding(
              padding: const EdgeInsets.only(left: 20),
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
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 15.w,
                  runSpacing: 10.h,
                  children: controller.categories
                      .map((cat) => _buildFilterChip(cat.name, id: cat.id, isCategory: true))
                      .toList(),
                ),
              );
            }),
        
            SizedBox(height: 20.h),
        
            // Distance সেকশন
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CommonText(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blue1,
                text: AppString.distance,
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 15.w,
                runSpacing: 10.h,
                children: distanceOptions.map((opt) {
                  return _buildFilterChip(
                    opt['label']!,
                    min: opt['min'],
                    max: opt['max'],
                    isCategory: false,
                  );
                }).toList(),
              )),

        
            SizedBox(height: 40.h),
        
            // Apply Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CommonButton(
                text: AppString.applyFilter,
                onTap: () => controller.applyFilters(), // কন্ট্রোলারের নতুন মেথড কল
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {String? id, String? min, String? max, required bool isCategory}) {
    return Obx(() {
      bool isSelected;
      if (isCategory) {
        isSelected = controller.tempSelectedCategoryId.value == id;
      } else {
        isSelected = controller.tempMinKm.value == min && controller.tempMaxKm.value == max;
      }

      return GestureDetector(
        onTap: () {
          if (isCategory) {
            // ক্যাটাগরি টগল লজিক (একই ক্যাটাগরিতে ক্লিক করলে আন-সিলেক্ট হবে)
            if (controller.tempSelectedCategoryId.value == id) {
              controller.tempSelectedCategoryId.value = "";
            } else {
              controller.tempSelectedCategoryId.value = id ?? "";
            }
          } else {
            // ডিস্ট্যান্স টগল লজিক (toggleDistance মেথড কল)
            controller.toggleDistance(min ?? "", max ?? "");
          }
        },
        child: _chipContainer(label, isSelected),
      );
    });
  }

  Widget _chipContainer(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue1.withOpacity(0.15) : Colors.transparent,
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
    );
  }
}