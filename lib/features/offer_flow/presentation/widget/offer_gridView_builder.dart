import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/features/offer_flow/controller/offer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OfferGridviewBuilder extends StatelessWidget {
  OfferGridviewBuilder({super.key});

  final OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show loading indicator
      if (offerController.isLoadingOffers.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: CircularProgressIndicator(
              color: AppColors.blue1,
            ),
          ),
        );
      }

      // Show empty state
      if (offerController.offers.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_offer_outlined,
                  size: 64.sp,
                  color: AppColors.otpBorderColor,
                ),
                SizedBox(height: 16.h),
                CommonText(
                  text: "No offers available",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue1,
                ),
              ],
            ),
          ),
        );
      }

      // Show offers grid
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: offerController.offers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final offer = offerController.offers[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.offerDetailsScreen, arguments: offer.id);
            },
            child: Container(
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
                        padding: EdgeInsets.all(4.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            offer.getImageUrl(ApiEndPoint.imageBaseUrl),
                            height: 115.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 115.h,
                                width: double.infinity,
                                color: AppColors.otpBorderColor,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 40.sp,
                                  color: AppColors.blue1.withValues(alpha: 0.3),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 115.h,
                                width: double.infinity,
                                color: AppColors.otpBorderColor,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.blue1,
                                    strokeWidth: 2.w,
                                  ),
                                ),
                              );
                            },
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
                            fontSize: 10.sp,
                            color: AppColors.green1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 9.h,
                        left: 9.w,
                        child: GestureDetector(
                          onTap: () {
                            offerController.toggleFavourite(offer.id);
                          },
                          child: Obx(() {
                            final currentOffer = offerController.offers
                                .firstWhere((o) => o.id == offer.id);
                            return Container(
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
                              child: Icon(
                                currentOffer.isFavourite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: AppColors.redColor,
                                size: 16.sp,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonText(
                            textAlign: TextAlign.start,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue1,
                            text: offer.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          CommonText(
                            textAlign: TextAlign.start,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue1,
                            text: offer.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}