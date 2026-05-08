import 'package:carousel_slider/carousel_slider.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/offer_flow/controller/offer_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_image/app_image.dart';

class OfferDetailsScreen extends StatelessWidget {
  OfferDetailsScreen({super.key});

  final OfferDetailsController controller = Get.put(OfferDetailsController());


  final RxInt _currentImageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final offer = controller.offerDetails.value;
          if (offer == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ],
              ),
            );
          }
          return controller.isLoading.value?Center(child: CircularProgressIndicator()): SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Stack(
                    children: [
                      Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 220.h,
                              viewportFraction: 1.0,
                              autoPlay: offer.images.length > 1,
                              onPageChanged: (index, reason) {
                                _currentImageIndex.value = index;
                              },
                            ),
                            items: offer
                                .getAllImageUrls(ApiEndPoint.imageBaseUrl)
                                .map((imageUrl) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Image.network(
                                  imageUrl,
                                  height: 220.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 219.h,
                                      width: double.infinity,
                                      color: AppColors.otpBorderColor,
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 40.sp,
                                        color: AppColors.blue1.withValues(alpha: 0.3),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                          if (offer.images.length > 1)
                            Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(offer.images.length, (index) {
                                  return Container(
                                    width: 8.w,
                                    height: 8.h,
                                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentImageIndex.value == index
                                          ? AppColors.blue1
                                          : AppColors.blue1.withValues(alpha: 0.2),
                                    ),
                                  );
                                }),
                              )),
                            ),
                        ],
                      ),
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.gold50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_sharp,
                              size: 22.sp,
                              color: AppColors.blue1,
                            ),
                          ),
                        ),
                      ),
        
                      if (offer.discount?.enable == true)
                        Positioned(
                          top: 12.h,
                          right: 12.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.blueBase50,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "${offer.discount?.value}% Off",
                              style: TextStyle(
                                color: const Color(0xFF2E7D32),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
        
                  SizedBox(height: 20.h),
                  CommonText(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue1,
                    text: offer.name,
                  ),
                  SizedBox(height: 8.h),
                  CommonText(
                    style: TextStyle(
                      color: AppColors.blue1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'SFPro',
                    ),
                    text: offer.title,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Image.asset(AssetPath.locationIcon, height: 20.h, width: 20.w),
                      SizedBox(width: 5.w),
                      CommonText(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blue1,
                        text: offer.address,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(
                    height: 1.h,
                    thickness: 0.9,
                    color: AppColors.tabSelectedBorderColor,
                  ),
                  SizedBox(height: 16.h),
                  CommonText(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.blue1,
                    text: AppString.description,
                  ),
                  SizedBox(height: 8.h),
                  HtmlWidget(
                      offer.description,
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blue1,
                        fontFamily: 'SFPro',
                      ),
                    ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

