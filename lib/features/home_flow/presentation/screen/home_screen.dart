import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/features/notification_flow/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/route/app_route.dart';
import '../../../../core/stroge/storage_service.dart';
import '../../../../core/utils/app_color/app_color.dart';
import '../../../auth_flow/presentation/widget/logOutModel_widget.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../widget/home_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});


  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkPasswordStatus();
    });

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: CommonBottomNabVar(selectedIndex: 0),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w, left: 16.h, top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      notificationController.clearNotificationCount();
                      Get.toNamed(AppRoute.notificationScreen);
                    },
                    child: Obx(() =>
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Image.asset(
                              AssetPath.notificationIcon,
                              height: 28.h,
                              width: 28.w,
                              color: AppColors.yellow,
                            ),
                            if (notificationController.unreadCount.value > 0)
                              Positioned(
                                right: -2,
                                top: -2,
                                child: Container(
                                  padding: EdgeInsets.all(4.r),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16.w,
                                    minHeight: 16.h,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${notificationController.unreadCount
                                          .value}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )),
                  ),
                ),
              ),
              Expanded(
                child: HomeTabBar(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  void _checkPasswordStatus() {
    bool hasPasswordSave = LocalStorage.getBool('hasPasswordSave') ?? true;

    if (hasPasswordSave == false) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: const LogOutModelWidget(),
        ),
        barrierDismissible: false,
      );
    }
  }

}