// // import 'package:alpha_club/core/global/commont_text.dart';
// // import 'package:alpha_club/core/service/api/api_enpoint.dart';
// // import 'package:alpha_club/core/utils/app_color/app_color.dart';
// // import 'package:alpha_club/features/favorite/controller/favourite_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// //
// // class FavoriteGridviewBuilder extends StatelessWidget {
// //   FavoriteGridviewBuilder({super.key});
// //
// //   final FavouriteController controller = Get.put(FavouriteController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(() {
// //       if (controller.isLoading.value) {
// //         return Center(
// //           child: Padding(
// //             padding: EdgeInsets.symmetric(vertical: 40.h),
// //             child: CircularProgressIndicator(
// //               color: AppColors.blue1,
// //             ),
// //           ),
// //         );
// //       }
// //
// //       if (controller.favouriteOffers.isEmpty) {
// //         return Center(
// //           child: Padding(
// //             padding: EdgeInsets.symmetric(vertical: 40.h),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Icon(
// //                   Icons.favorite_border_rounded,
// //                   size: 64.sp,
// //                   color: AppColors.otpBorderColor,
// //                 ),
// //                 SizedBox(height: 16.h),
// //                 CommonText(
// //                   text: "No favourite offers yet",
// //                   fontSize: 16.sp,
// //                   fontWeight: FontWeight.w500,
// //                   color: AppColors.blue1,
// //                 ),
// //                 SizedBox(height: 8.h),
// //                 CommonText(
// //                   text: "Start adding offers to your favourites",
// //                   fontSize: 14.sp,
// //                   fontWeight: FontWeight.w400,
// //                   color: AppColors.blueBase,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       }
// //
// //       return GridView.builder(
// //         shrinkWrap: true,
// //         physics: const NeverScrollableScrollPhysics(),
// //         itemCount: controller.favouriteOffers.length,
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2,
// //           crossAxisSpacing: 12.w,
// //           mainAxisSpacing: 12.h,
// //           childAspectRatio: 0.91,
// //         ),
// //         itemBuilder: (context, index) {
// //           final offer = controller.favouriteOffers[index];
// //           return Container(
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(12.r),
// //               border: Border.all(color: AppColors.otpBorderColor),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Stack(
// //                   children: [
// //                     Padding(
// //                       padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
// //                       child: ClipRRect(
// //                         borderRadius: BorderRadius.circular(8.r),
// //                         child:
// //                         // Image.network(
// //                         //   offer.getImageUrl(ApiEndPoint.imageBaseUrl),
// //                         //   height: 120.h,
// //                         //   width: double.infinity,
// //                         //   fit: BoxFit.cover,
// //                         //   errorBuilder: (context, error, stackTrace) {
// //                         //     return Container(
// //                         //       height: 120.h,
// //                         //       width: double.infinity,
// //                         //       color: AppColors.otpBorderColor,
// //                         //       child: Icon(
// //                         //         Icons.image_not_supported_outlined,
// //                         //         size: 40.sp,
// //                         //         color: AppColors.blue1.withValues(alpha: 0.3),
// //                         //       ),
// //                         //     );
// //                         //   },
// //                         //   loadingBuilder: (context, child, loadingProgress) {
// //                         //     if (loadingProgress == null) return child;
// //                         //     return Container(
// //                         //       height: 120.h,
// //                         //       width: double.infinity,
// //                         //       color: AppColors.otpBorderColor,
// //                         //       child: Center(
// //                         //         child: CircularProgressIndicator(
// //                         //           color: AppColors.blue1,
// //                         //           strokeWidth: 2.w,
// //                         //         ),
// //                         //       ),
// //                         //     );
// //                         //   },
// //                         // ),
// //                         Image.network(
// //                           "${ApiEndPoint.imageBaseUrl}${offer.image}",
// //                           height: 120.h,
// //                           width: double.infinity,
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                     ),
// //
// //                     Positioned(
// //                       top: 9.h,
// //                       right: 9.w,
// //                       child: offer.discount?.enable == true
// //                           ? Container(
// //                         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
// //                         decoration: BoxDecoration(
// //                           color: AppColors.blueBase50,
// //                           borderRadius: BorderRadius.circular(20.r),
// //                         ),
// //                         child: CommonText(
// //                           text: "${offer.discount?.value}% Off",
// //                           fontWeight: FontWeight.w500,
// //                           fontSize: 12.sp,
// //                           color: AppColors.green1,
// //                         ),
// //                       )
// //                           : const SizedBox.shrink(),
// //                     ),
// //                     Positioned(
// //                       top: 9.h,
// //                       left: 9.w,
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           controller.removeFavourite(offer.id);
// //                         },
// //                         child: Container(
// //                           height: 24.w,
// //                           width: 24.w,
// //                           decoration: BoxDecoration(
// //                             shape: BoxShape.circle,
// //                             color: Colors.white,
// //                             boxShadow: [
// //                               BoxShadow(
// //                                 color: Colors.black.withValues(alpha: 0.1),
// //                                 blurRadius: 4,
// //                                 offset: const Offset(0, 2),
// //                               ),
// //                             ],
// //                           ),
// //                           child: Center(
// //                             child: Icon(
// //                               Icons.favorite_rounded,
// //                               color: AppColors.redColor,
// //                               size: 18.sp,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 Flexible(
// //                   child: Padding(
// //                     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         CommonText(
// //                           textAlign: TextAlign.start,
// //                           fontSize: 14.sp,
// //                           fontWeight: FontWeight.w500,
// //                           color: AppColors.blue1,
// //                           text: offer.name,
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                         SizedBox(height: 4.h),
// //                         CommonText(
// //                           textAlign: TextAlign.start,
// //                           fontSize: 12.sp,
// //                           fontWeight: FontWeight.w400,
// //                           color: AppColors.blue1,
// //                           text: offer.title,
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       );
// //     });
// //   }
// // }
//
// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/core/service/api/api_enpoint.dart';
// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:alpha_club/features/favorite/controller/favourite_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class FavoriteGridviewBuilder extends StatelessWidget {
//   FavoriteGridviewBuilder({super.key});
//
//   final FavouriteController controller = Get.put(FavouriteController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 100.h),
//             child: CircularProgressIndicator(color: AppColors.blue1),
//           ),
//         );
//       }
//       if (controller.favouriteOffers.isEmpty) {
//         return Center(
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 100.h),
//             child: Column(
//               children: [
//                 Icon(Icons.favorite_border_rounded, size: 64.sp, color: Colors.grey[300]),
//                 SizedBox(height: 16.h),
//                 CommonText(
//                   text: "No favourite offers yet",
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.blue1,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//       return GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: controller.favouriteOffers.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12.w,
//           mainAxisSpacing: 12.h,
//           childAspectRatio: 0.82,
//         ),
//         itemBuilder: (context, index) {
//           final offer = controller.favouriteOffers[index];
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: AppColors.otpBorderColor.withOpacity(0.5)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//
//                     Padding(
//                       padding: EdgeInsets.all(4.w),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8.r),
//                         child: Image.network(
//                           "${ApiEndPoint.imageBaseUrl}${offer.image}",
//                           height: 110.h,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) => Container(
//                             height: 110.h,
//                             color: Colors.grey[200],
//                             child: const Icon(Icons.image_not_supported_outlined),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     if (offer.discount?.enable == true)
//                       Positioned(
//                         top: 10.h,
//                         right: 10.w,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                           decoration: BoxDecoration(
//                             color: AppColors.blueBase50,
//                             borderRadius: BorderRadius.circular(20.r),
//                           ),
//                           child: CommonText(
//                             text: "${offer.discount?.value}% Off",
//                             fontWeight: FontWeight.w500,
//                             fontSize: 11.sp,
//                             color: AppColors.green1,
//                           ),
//                         ),
//                       ),
//
//                     Positioned(
//                       top: 10.h,
//                       left: 10.w,
//                       child: GestureDetector(
//                         onTap: () => controller.removeFavourite(offer.id),
//                         child: Container(
//                           padding: EdgeInsets.all(4.w),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: Icon(
//                             Icons.favorite_rounded,
//                             color: AppColors.redColor,
//                             size: 18.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CommonText(
//                         text: offer.name ?? "",
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.bold,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 4.h),
//                       CommonText(
//                         text: offer.title ?? "",
//                         fontSize: 11.sp,
//                         color: Colors.grey,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import '../../controller/favourite_controller.dart';

class FavoriteGridviewBuilder extends StatelessWidget {
  FavoriteGridviewBuilder({super.key});

  final FavouriteController controller = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: AppColors.blue1));
      }

      if (controller.favouriteOffers.isEmpty) {
        return _buildEmptyState();
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.favouriteOffers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          final offer = controller.favouriteOffers[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.otpBorderColor.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageStack(offer),
                _buildOfferDetails(offer),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildImageStack(offer) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              "${ApiEndPoint.imageBaseUrl}${offer.image}",
              height: 110.h, width: double.infinity, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(height: 110.h, color: Colors.grey[200], child: Icon(Icons.image_not_supported)),
            ),
          ),
        ),
        if (offer.discount?.enable == true)
          Positioned(
            top: 10.h, right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: AppColors.blueBase50, borderRadius: BorderRadius.circular(20.r)),
              child: CommonText(text: "${offer.discount?.value}% Off", fontSize: 11.sp, color: AppColors.green1, fontWeight: FontWeight.w500),
            ),
          ),
        Positioned(
          top: 10.h, left: 10.w,
          child: GestureDetector(
            onTap: () => controller.removeFavourite(offer.id),
            child: CircleAvatar(radius: 14.r, backgroundColor: Colors.white, child: Icon(Icons.favorite_rounded, color: AppColors.redColor, size: 18.sp)),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferDetails(offer) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: offer.name, fontSize: 13.sp, fontWeight: FontWeight.bold, maxLines: 1),
          SizedBox(height: 4.h),
          CommonText(text: offer.title, fontSize: 11.sp, color: Colors.grey, maxLines: 2),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100.h),
          Icon(Icons.favorite_border_rounded, size: 64.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          CommonText(text: "No favourite offers yet", fontSize: 16.sp, color: AppColors.blue1),
        ],
      ),
    );
  }
}