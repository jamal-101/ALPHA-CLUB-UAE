import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/features/favorite/controller/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../offer_flow/controller/offer_details_controller.dart';
import '../../../offer_flow/presentation/screen/offer_details_screen.dart';

class FavoriteGridviewBuilder extends StatelessWidget {
  FavoriteGridviewBuilder({super.key});

  final FavouriteController controller = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: CircularProgressIndicator(
              color: AppColors.blue1,
            ),
          ),
        );
      }

      if (controller.favouriteOffers.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 64.sp,
                  color: AppColors.otpBorderColor,
                ),
                SizedBox(height: 16.h),
                CommonText(
                  text: "No favourite offers yet",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue1,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: "Start adding offers to your favourites",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blueBase,
                ),
              ],
            ),
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: controller.favouriteOffers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.91,
        ),
        itemBuilder: (context, index) {
          final offer = controller.favouriteOffers[index];
          return GestureDetector(
            onTap: (){
              final detailsController = Get.put(OfferDetailsController());
              detailsController.fetchOfferDetails(offer.id);
              Get.to(() => OfferDetailsScreen());
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
                        padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: offer.images.isNotEmpty
                              ? Image.network(
                            "${ApiEndPoint.imageBaseUrl}${offer.images.first}",
                            height: 120.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 120.h,
                              color: AppColors.otpBorderColor,
                              child: Icon(Icons.image_not_supported_outlined, color: AppColors.blue1),
                            ),
                          )
                              : Container(
                            height: 120.h,
                            width: double.infinity,
                            color: AppColors.otpBorderColor,
                            child: Icon(Icons.image_outlined, color: AppColors.blue1),
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
                            text: "${offer.discount?.value ?? 0}% Off",
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
                            controller.removeFavourite(offer.id);
                          },
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
                              child: Icon(
                                Icons.favorite_rounded,
                                color: AppColors.redColor,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
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
                          SizedBox(height: 4.h),
                          CommonText(
                            textAlign: TextAlign.start,
                            fontSize: 12.sp,
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
