import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ContactUsContainer extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  const ContactUsContainer({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.otpBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 16.sp,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                  ),
                ),
                SizedBox(height: 4.h),
                HtmlWidget(
                  subTitle,
                  textStyle: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blueBase,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}