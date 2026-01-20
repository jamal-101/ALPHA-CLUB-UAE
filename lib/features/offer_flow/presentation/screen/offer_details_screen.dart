import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/offer_flow/controller/offer_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';


class OfferDetailsScreen extends StatelessWidget {
  OfferDetailsScreen({super.key});

  final OfferDetailsController controller = Get.put(OfferDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.blue1,
            ),
          );
        }

        final offer = controller.offerDetails.value;
        if (offer == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sp,
                  color: AppColors.otpBorderColor,
                ),
                SizedBox(height: 16.h),
                CommonText(
                  text: "Offer not found",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue1,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        offer.getImageUrl(ApiEndPoint.imageBaseUrl),
                        height: 220.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 219.h,
                            width: double.infinity,
                            color: AppColors.otpBorderColor,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 64.sp,
                              color: AppColors.blue1.withValues(alpha: 0.3),
                            ),
                          );
                        },
                        // loadingBuilder: (context, child, loadingProgress) {
                        //   if (loadingProgress == null) return child;
                        //   return Container(
                        //     height: 219.h,
                        //     width: double.infinity,
                        //     color: AppColors.otpBorderColor,
                        //     child: Center(
                        //       child: CircularProgressIndicator(
                        //         color: AppColors.blue1,
                        //       ),
                        //     ),
                        //   );
                        // },
                      ),
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
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
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
                    // Positioned(
                    //   bottom: 12.h,
                    //   right: 12.w,
                    //   child: GestureDetector(
                    //     onTap: () => controller.toggleFavourite(),
                    //     child: Container(
                    //       height: 32.w,
                    //       width: 32.w,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.white,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black.withValues(alpha: 0.2),
                    //             blurRadius: 4,
                    //             offset: const Offset(0, 2),
                    //           ),
                    //         ],
                    //       ),
                    //       child: Icon(
                    //         offer.isFavourite
                    //             ? Icons.favorite_rounded
                    //             : Icons.favorite_outline_rounded,
                    //         color: AppColors.redColor,
                    //         size: 20.sp,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                CommonText(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blue1,
                  text: offer.category.name,
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
                  renderMode: RenderMode.column,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}