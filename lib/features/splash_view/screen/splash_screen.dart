import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:flutter/material.dart';
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
              child: Image.asset(AssetPath.splashImage),
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

