import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';


class ProfileDataContainer extends StatelessWidget {
  final String imagePath;
  final String userName;
  final String membershipType;
  final String userId;
  final bool showBorder;
  final bool showEditButton;
  final bool usePadding;

  const ProfileDataContainer({
    super.key,
    required this.imagePath,
    required this.userName,
    required this.membershipType,
    required this.userId,
    this.showBorder = true,
    this.showEditButton = true,
    this.usePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(

        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: showBorder ? Border.all(width: 1.w, color: AppColors.whiteFoundation1) : null,
      ),
      child: Padding(
        padding: usePadding ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h) : EdgeInsets.zero,
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
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: userName,
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      color: const Color(0xFF1A2A4D),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CommonText(
                    text: membershipType,
                    style: TextStyle(color: AppColors.goldColor, fontSize: 14.sp),
                  ),
                  CommonText(
                    text: userId,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            if (showEditButton)
           Container(
              height: 36.h,
              width: 36.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.foundation1,
              ),
              child: Center(
                child: Image.asset(
                  AssetPath.editeIcon,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}