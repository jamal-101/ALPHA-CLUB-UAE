import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alpha_club/core/global/common_app_bar.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController = Get.put(NotificationController());


    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationController.refreshNotificationData();
      notificationController.clearNotificationCount();
      notificationController.clearNotificationCount();
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            CommonAppBar(
              title: "Notification",
              onTap: () => Get.back(),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  backgroundColor: const Color(0xFF1E1E1E),
                  color: Colors.white,
                  onRefresh: () async {
                    await notificationController.getNotifications();
                  },
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: notificationController.notifications.length,
                    padding: EdgeInsets.only(top: 12.h),
                    itemBuilder: (context, index) {
                      final item = notificationController.notifications[index];
                      return GestureDetector(
                        onTap: (){
                          if (item['seen'] == false) {
                            notificationController.markAsSeen(item['_id']);
                          }
                        },
                        child: _buildNotificationCard(
                          title: item['title'] ?? " ",
                          message: item['message'] ?? "",
                          time: item['createdAt'] ?? "",
                          isSeen: item['seen'] ?? true,
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required bool isSeen,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSeen ? AppColors.borderColor : Colors.blue.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            // if (!isSeen)
            //   Positioned(
            //     left: 0,
            //     top: 0,
            //     bottom: 0,
            //     child: Container(
            //       width: 4.w,
            //       color: Colors.yellow,
            //     ),
            //   ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 28.h,
                        width: 28.w,
                        decoration: BoxDecoration(
                          color: isSeen ? const Color(0xFFE0F2FE) : Color(0xFFC3E5FC),
                          borderRadius: BorderRadius.circular(8.r),
                        ),child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Image.asset(AssetPath.notificationIcon,color: Color(0xFF065C95)),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0xFF242424),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              message,
                              maxLines: 20,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xFF242424),
                                fontSize: 13.sp,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        formatTimeAgo(time),
                        style: TextStyle(
                          color: Color(0xFF242424),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTimeAgo(String dateTimeString) {
    if (dateTimeString.isEmpty) return "";
    try {
      DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
      Duration diff = DateTime.now().difference(dateTime);
      if (diff.inDays >= 1) return "${diff.inDays}d ago";
      if (diff.inHours >= 1) return "${diff.inHours}h ago";
      if (diff.inMinutes >= 1) return "${diff.inMinutes}m ago";
      return "Just now";
    } catch (e) {
      return "";
    }
  }
}