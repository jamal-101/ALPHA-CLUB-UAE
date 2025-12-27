import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../../../core/utils/app_string/app_string.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../widget/filter_bottomSheet.dart';
import '../widget/offer_gridView_builder.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CommonBottomNabVar(selectedIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: AppColors.blue1,
                        text: AppString.exclusiveOffer,
                      ),
                      CommonText(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.blueBase,
                        ),
                        text: AppString.offersAvailable,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => FilterSheet(),
                      );
                    },
                      child: Image.asset(AssetPath.filterIcon, height: 36.h, width: 36.w)),
                ],
              ),
              SizedBox(height: 16.h),
              OfferGridviewBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}