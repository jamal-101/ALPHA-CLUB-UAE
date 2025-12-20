import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDataContainer extends StatelessWidget {
  const ProfileDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.whiteFoundation
        )
      ),child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.goldColor,
          ),child: Image.asset(AssetPath.userProfile),
        )
      ],
    ),
    );
  }
}
