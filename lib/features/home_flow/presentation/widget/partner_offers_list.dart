// import 'package:alpha_club/core/global/commont_text.dart';
// import 'package:alpha_club/core/utils/app_color/app_color.dart';
// import 'package:alpha_club/core/utils/app_image/app_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class PartnerOffersList extends StatelessWidget {
//   const PartnerOffersList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> dealsData = [
//       {
//         "gradient": const LinearGradient(
//           begin: Alignment.bottomRight,
//           end: Alignment.topLeft,
//           colors: [Color(0xFF8227D2), Color(0xFFAF46FE)],
//         ),
//         "color": const Color(0xFFD500F9),
//         "title": "Exclusive deals",
//         "subtitle": "from our premium partners",
//         "image": AssetPath.exclusiveDetailsImage,
//         "text": "Explore Offers",
//       },
//       {
//         "gradient": const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFFD9500), Color(0xFFF96A00)],
//         ),
//         "color": const Color(0xFFFE9A00),
//         "title": "Summer Offers",
//         "subtitle": "get amazing discounts",
//         "image": AssetPath.premiumServiceImage,
//         "text": "Learn More",
//       },
//       {
//         "gradient": const LinearGradient(
//           begin: Alignment.bottomRight,
//           end: Alignment.topLeft,
//           colors: [Color(0xFFE10D85), Color(0xFFAF46FE)],
//         ),
//         "color": const Color(0xFFAD46FF),
//         "title": "Tech Deals",
//         "subtitle": "latest gadgets for you",
//         "image": AssetPath.partnerImage,
//         "text": "Explore Offers",
//       },
//       {
//         "gradient": null,
//         "color": const Color(0xFFF3023C),
//         "title": "Fashion Sale",
//         "subtitle": "trending styles on sale",
//         "image": AssetPath.luxuryImage,
//         "text": "Discover More",
//       },
//     ];
//
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: dealsData.length,
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       itemBuilder: (context, index) {
//         final item = dealsData[index];
//         final bool hasGradient = item["gradient"] != null;
//
//         return Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             width: 280.w,
//             margin: EdgeInsets.only(right: 16.w, top: 10.h),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20.r),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // হেডার অংশ
//                 Container(
//                   padding: EdgeInsets.all(12.w),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     gradient: hasGradient ? item["gradient"] : null,
//                     color: hasGradient ? null : item["color"],
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(19.r),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                      CommonText(
//                        style: TextStyle(
//                          fontSize: 16.sp,
//                          color: AppColors.appBackgroundColor,
//                          fontWeight: FontWeight.w500,
//                          fontFamily: 'SFPro'
//                        ),
//                          text:  item["title"],
//                      ),
//                       CommonText(
//                        style: TextStyle(
//                          fontSize: 14.sp,
//                          color: AppColors.strokeColor,
//                          fontWeight: FontWeight.w400,
//                          fontFamily: 'SFPro'
//                        ),
//                          text:  item["subtitle"],
//                      ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(12.w),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12.r),
//                     child: Image.asset(
//                       item["image"],
//                       height: 110.h,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                   child: Container(
//                     width: double.infinity,
//                     height: 42.h,
//                     decoration: BoxDecoration(
//                       color: item["color"],
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Center(
//                       child:
//                       CommonText(
//                         style: TextStyle(
//                             fontSize: 16.sp,
//                             color: AppColors.appBackgroundColor,
//                             fontWeight: FontWeight.w400,
//                             fontFamily: 'SFPro'
//                         ),
//                         text:   item["text"],
//                       ),
//                       ),
//                     ),
//                   ),
//                 SizedBox(height: 12.h),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
