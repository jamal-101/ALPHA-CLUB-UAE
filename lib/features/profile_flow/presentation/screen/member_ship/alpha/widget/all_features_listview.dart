import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AllFeaturesListview extends StatelessWidget {
  AllFeaturesListview({super.key});

  final List<Map<String, dynamic>> benefitDetails = [
    {
      "image": AssetPath.memberShip_card1,
      "title": "Digital Membership Card",
      "desc": "Access your digital membership card anytime, anywhere",
    },
    {
      "image": AssetPath.offerImage,
      "title": "Exclusive Offers & Discounts",
      "desc": "Special discounts from automotive brands and partners",
    },
    {
      "image": AssetPath.eventImage,
      "title": "Industry Events Access",
      "desc": "Priority registration for automotive events and exhibitions",
    },
    {
      "image": AssetPath.locationImage,
      "title": "Club Facilities Access",
      "desc": "Access to exclusive venues like beach clubs and gyms",
    },
    {
      "image": AssetPath.priorityImage,
      "title": "Priority Support",
      "desc": "Connect with automotive industry professionals worldwide",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: benefitDetails.length,
      itemBuilder: (context, index) {
        final item = benefitDetails[index];

        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.otpBorderColor,width: 1.w),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.goldColor1.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(10.w),
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.contain,
                  ),
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
                      text: item['title'],),
                    SizedBox(height: 4.h),
                    CommonText(
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'SFPro',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blueBase
                      ),
                      text: item['desc'],)
                  ],
                ),
              ),
             Image.asset(AssetPath.checkIcon,color: AppColors.green1,height: 16.h,width: 16.w,)
            ],
          ),
        );
      },
    );
  }
}