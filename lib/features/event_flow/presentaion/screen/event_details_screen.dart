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

  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    eventController.fetchEventDetails(eventId);

    return Scaffold(
      body: Obx(() {
        if (eventController.isEventDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final event = eventController.singleEventDetails;
        if (event.isEmpty) return const Center(child: Text("No Event Details Found"));

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
                        "${ApiEndPoint.imageBaseUrl}${event['image'] ?? ""}",
                        height: 219.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 219.h,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image),
                        ),
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
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.blueBase50,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CommonText(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green, // AppColors.green1
                          text: "30%",
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
                  text: event['name'] ?? event['title'] ?? "",
                ),
                SizedBox(height: 8.h),
                CommonText(
                  style: TextStyle(
                    color: AppColors.blue1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: 'SFPro',
                  ),
                  text: "Event Group / Organizer",
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
                      text: event['location'] ?? "No Location Provided",
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
                const Divider(height: 1, thickness: 0.9, color: AppColors.tabSelectedBorderColor),
                SizedBox(height: 16.h),

                CommonText(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.blue1,
                  text: "Description",
                ),

                SizedBox(height: 12.h),

                HtmlWidget(
                  event['description'] ?? "No description available.",
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
        );
      }),
    );
  }
}