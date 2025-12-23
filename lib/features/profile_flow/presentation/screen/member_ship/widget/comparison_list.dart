import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart'; // আপনার প্রোজেক্ট পাথ অনুযায়ী

class ComparisonList extends StatelessWidget {
  ComparisonList({super.key});

  final List<Map<String, dynamic>> comparisonData = [
    {"title": "Digital Membership Card", "regular": true, "family": true},
    {"title": "Exclusive Offers & Discounts", "regular": true, "family": true},
    {"title": "Industry Events Access", "regular": true, "family": true},
    {"title": "Club Facilities Access", "regular": true, "family": true},
    {"title": "Industry News Feed", "regular": true, "family": true},
    {"title": "Priority Support", "regular": true, "family": true},
    {"title": "Networking Opportunities", "regular": true, "family": true},
    {"title": "Premium Member Badge", "regular": true, "family": true},
    {"title": "Spouse Membership", "regular": false, "family": true},
    {"title": "Children Memberships", "regular": false, "family": true},
    {"title": "Family Event Packages", "regular": false, "family": true},
    {"title": "Shared Benefits Management", "regular": false, "family": true},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comparisonData.length,
      itemBuilder: (context, index) {
        final item = comparisonData[index];

        return Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue1,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: item['regular']
                      ? Image.asset(
                    AssetPath.checkIcon,
                    height: 12.sp,
                    width: 12.sp,
                    color: AppColors.green1,
                  )
                      : Icon(
                    Icons.close,
                    color: Colors.grey.shade400,
                    size: 18.sp,
                  ),
                ),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: item['family']
                      ? Image.asset(
                    AssetPath.checkIcon,
                    color: AppColors.green1,
                    height: 12.sp,
                    width: 12.sp,
                  )
                      : Icon(
                    Icons.close,
                    color: AppColors.foundationWhite,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}