import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhatOfferWidget extends StatelessWidget {
  const WhatOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> offers = [
      "24/7 secure key drop & collection",
      "Real-time tracking through our mobile app",
      "Integrated payments via Stripe, Apple Pay, and local cards",
      "Host & Partner dashboards with analytics",
      "Multi-language interface for regional accessibility",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Container(
                          height: 6.w,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: AppColors.blue1,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CommonText(
                          textAlign: TextAlign.start,
                          fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue1,
                            text: offers[index],
                        )
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}