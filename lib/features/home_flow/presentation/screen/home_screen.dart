import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../../core/stroge/storage_service.dart';
import '../../../auth_flow/presentation/widget/logOutModel_widget.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../widget/home_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkPasswordStatus();
    });

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar:  CommonBottomNabVar(selectedIndex: 0),
        body: SafeArea(
          child: Column(
            children: [
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