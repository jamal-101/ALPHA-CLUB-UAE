import 'package:alpha_club/core/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../../../core/utils/app_string/app_string.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';
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

              SizedBox(height: 16.h),
              Center(
                child: CommonText(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue1,
                  text: AppString.ourSponsors,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.ourSponsorScreen);
                    },
                    child: CustomBrandCard(
                      imagePath: AssetPath.autoMillennium,
                      title: AppString.autoMillennium,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.ourSponsorScreen);
                    },
                    child: CustomBrandCard(
                      imagePath: AssetPath.alImage,
                      title: AppString.autoMillennium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.ourSponsorScreen);
                    },
                    child: CustomBrandCard(
                      imagePath: AssetPath.autoMillennium,
                      title: AppString.autoMillennium,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.ourSponsorScreen);
                    },
                    child: CustomBrandCard(
                      imagePath: AssetPath.alImage,
                      title: AppString.autoMillennium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}