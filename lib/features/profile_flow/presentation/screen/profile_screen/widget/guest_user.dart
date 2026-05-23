import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';
import '../../../../../auth_flow/presentation/screen/login_screen.dart';

class GuestUser extends StatelessWidget {
  const GuestUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LoginScreen.isAppLied.value == true
              ? Color(0xFF4F6185).withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1.w, color: AppColors.whiteFoundation1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 78.h,
                width: 78.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 2.w, color: AppColors.goldColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.asset(
                    AssetPath.userProfile,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: "Guest User",
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        color: const Color(0xFF4F6185).withValues(alpha: 0.4),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CommonText(
                      text: "Guest Member",
                      style: TextStyle(
                        color: const Color(0xFF4F6185).withValues(alpha: 0.4),
                        fontSize: 14.sp,
                      ),
                    ),
                    CommonText(
                      text: "Guest Id",
                      style: TextStyle(
                        color: const Color(0xFF4F6185).withValues(alpha: 0.4),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    );
  }
}