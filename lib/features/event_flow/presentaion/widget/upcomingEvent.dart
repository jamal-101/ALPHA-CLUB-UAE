import 'package:alpha_club/features/event_flow/presentaion/screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../core/global/commont_text.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../../core/utils/app_image/app_image.dart';
import '../../controller/event_controller.dart';

class UpComingEvent extends StatelessWidget {
  UpComingEvent({super.key});

  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return RefreshIndicator(
        color: Color(0xFF233A66),
        backgroundColor: AppColors.appBackgroundColor,
        onRefresh: () async {
          await eventController.fetchEvents();
        },
        child: GridView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: eventController.eventList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            final item = eventController.eventList[index];
           final String eventId = item['_id'] ?? "";

            return GestureDetector(
              onTap: () => Get.to(EventDetailsScreen(eventId: eventId)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          "${ApiEndPoint.imageBaseUrl}${item["image"] ?? ""}",
                          height: 144.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 6.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue1,
                                fontFamily: 'SFPro',
                              ),
                              maxLines: 1,
                              text: item["title"] ?? "",
                            ),
                            SizedBox(height: 6.h),
                            CommonText(
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.blueBase,
                              ),
                              text: (item["description"] ?? "").replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ""),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Image.asset(AssetPath.calenderIcon, height: 16.h, width: 16.w, color: AppColors.goldColor1),
                                      SizedBox(width: 4.w),
                                      Flexible(
                                        child: CommonText(
                                          fontSize: 10.sp,
                                          text: item["eventDate"] != null ? item["eventDate"].toString().split('T')[0] : "",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16.sp, color: AppColors.goldColor1),
                                    SizedBox(width: 2.w),
                                    CommonText(
                                      fontSize: 10.sp,
                                      text: item["eventTime"] ?? "",
                                    ),
                                  ],
                                ),
                              ],
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
        ),
      );
    });
  }
}