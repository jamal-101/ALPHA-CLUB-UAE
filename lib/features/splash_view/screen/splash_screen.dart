import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPath.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Center(
              child: Column(
                children: [
                Image.asset(AssetPath.splashImage,height: 214.h,width: 299.w,),
                  Padding(
                    padding:  EdgeInsets.only(left: 60,right: 60),
                    child: CommonText(
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteFoundation,
                        fontFamily: 'SFPro',
                      ),
                      text: "Delivering Excellence Back to Those who Drive It",
                    ),
                  ),
                ]
            ),
            ),
            const Spacer(flex: 2),
            Obx(() => SizedBox(
              width: 200,
              height: 4,
              child: LinearProgressIndicator(
                value: splashController.progressValue.value,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
              ),
            )),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

