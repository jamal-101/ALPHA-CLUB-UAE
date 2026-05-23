import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../../../core/utils/app_string/app_string.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../../controller/offer_controller.dart';
import '../widget/filter_bottomSheet.dart';
import '../widget/offer_gridView_builder.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offerController = Get.put(OfferController());

    return Scaffold(
      bottomNavigationBar: CommonBottomNabVar(selectedIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                      Obx(() {
                        final count = offerController.offers.length;
                        final text = count == 1
                            ? '1 offer available'
                            : '$count offers available';
                        return CommonText(
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: AppColors.blueBase,
                          ),
                          text: text,
                        );
                      })
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => FilterSheet(),
                        );
                      },
                      child: Image.asset(AssetPath.filterIcon,
                          height: 36.h, width: 36.w)),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(child: OfferGridviewBuilder()),
            ],
          ),
        ),
      ),
    );
  }
}