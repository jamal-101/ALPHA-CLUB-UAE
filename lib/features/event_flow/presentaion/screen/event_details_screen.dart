import 'package:alpha_club/features/event_flow/presentaion/widget/event_status_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../controller/event_controller.dart';


class EventDetailsScreen extends StatelessWidget {
  final String eventId;
  EventDetailsScreen({super.key, required this.eventId});

  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    eventController.fetchEventDetails(eventId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventController.fetchEventDetails(eventId);
    });
    return Scaffold(
      body: Obx(() {
        final event = eventController.singleEventDetails;
        return RefreshIndicator(
          color: const Color(0xFF233A66),
          backgroundColor: Colors.white,
          onRefresh: () async {
            await eventController.fetchEventDetails(eventId);
          },
          child: SingleChildScrollView(
            physics : AlwaysScrollableScrollPhysics(),
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
                          "${ApiEndPoint.imageBaseUrl}${event['image'] ?? ""}",
                          // height: 21.h,
                          width: double.infinity,
                          fit: BoxFit.contain,
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
                      ),
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: const BoxDecoration(
                              color: AppColors.gold50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.arrow_back_sharp, size: 22.sp, color: AppColors.blue1),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   top: 12.h,
                      //   right: 12.w,
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                      //     decoration: BoxDecoration(
                      //       color: AppColors.blueBase50,
                      //       borderRadius: BorderRadius.circular(20.r),
                      //     ),
                      //     child: CommonText(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500,
                      //       color: Colors.green, // AppColors.green1
                      //       text: "30%",
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CommonText(
                          textAlign: TextAlign.start,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue1,
                          text: event['name'] ??  "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      EventStatusButton(eventId: eventId,),
                    ]
                  ),
                  SizedBox(height: 8.h),
                  CommonText(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.blue1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontFamily: 'SFPro',
                    ),
                    text: event['title'] ?? "",
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
                        text: event['location'] ?? " ",
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(height: 1, thickness: 0.3, color: Color(0xFFF3F4F6)),
                  SizedBox(height: 16.h),

                  CommonText(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.blue1,
                    text: "Description",
                  ),

                  SizedBox(height: 12.h),

                  HtmlWidget(
                    event['description'] ?? " ",
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blue1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}


