import 'package:alpha_club/core/route/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../../../core/utils/app_string/app_string.dart';
import '../../../profile_flow/presentation/screen/profile_screen/widget/custom_brand_card.dart';

class SponsorWidgetScreen extends StatelessWidget {
  const SponsorWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Column(
        children: [
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
              CustomBrandCard(
                imagePath: AssetPath.alImage,
                title: AppString.autoMillennium,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBrandCard(
                imagePath: AssetPath.autoMillennium,
                title: AppString.autoMillennium,
              ),
              CustomBrandCard(
                imagePath: AssetPath.alImage,
                title: AppString.autoMillennium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
