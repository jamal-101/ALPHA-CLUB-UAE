import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FavoriteGridviewBuilder extends StatelessWidget {
  const FavoriteGridviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> offers = [
      {
        "name": "Jumeirah One",
        "desc": "Buy 1 Get 1 Free at Brunch",
        "image": AssetPath.gridImage1,
      },
      {
        "name": "Al Tayer",
        "desc": "FOC Oil and Filter Change with Every Service",
        "image": AssetPath.gridImage1,
      },
      {"name": "Nandos", "desc": "2-4-1", "image": AssetPath.gridImage1},
      {
        "name": "Beauty Salon",
        "desc": "Buy 1 Get 1 Free",
        "image": AssetPath.gridImage1,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: offers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.91,
      ),
      itemBuilder: (context, index) {
        final item = offers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.otpBorderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4, left: 4, right: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0.r),
                      child: Image.asset(
                        item["image"]!,
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 9.h,
                    right: 9.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueBase50,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CommonText(
                        text: "30% Off",
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColors.green1,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 9.h,
                    left: 9.w,
                    child: Container(
                      height: 24.w,
                      width: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(Icons.favorite_rounded,color: AppColors.redColor,size: 18),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 4, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      textAlign: TextAlign.start,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue1,
                      text: item['name']!,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      textAlign: TextAlign.start,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue1,
                      text: item["desc"]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
