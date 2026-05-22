import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/profile_controller.dart'; // আপনার সঠিক পাথ দিন
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 50.sp,
          ),
          SizedBox(height: 12.h),
          CommonText(
            text: "Delete Account?",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blue1,
          ),
          SizedBox(height: 10.h),
          CommonText(
            text: "Are you sure you want to delete your account? This action cannot be undone.",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey.withValues(alpha: 0.6),
            maxLines: 3,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(width: 12.w),
              // Delete Button
              Expanded(
                child: Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    onPressed: profileController.isLoading.value
                        ? null
                        : () async {
                      await profileController.deleteAccount();
                    },
                    child: profileController.isLoading.value
                        ? SizedBox(
                      height: 20.sp,
                      width: 20.sp,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text("Delete", style: TextStyle(color: Colors.white)),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}