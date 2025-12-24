import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../controller/nab_controller.dart';

class CommonBottomNabVar extends StatelessWidget {
  const CommonBottomNabVar({super.key, required int selectedIndex});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    return Obx(
      () => Container(
        height: 100,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.appBackgroundColor, width: 1),
          ),
        ),
        child: StylishBottomBar(
          elevation: 0,
          option: AnimatedBarOptions(
            iconSize: 30,
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
          ),
          backgroundColor: AppColors.appBackgroundColor,
          items: [
            BottomBarItem(
              icon: gradientImageContainer(imagePath: AssetPath.homeIcon,
                  index: 0,
                  currentIndex: controller.currentIndex.value
              ),
              title: gradientText(text: AppString.home,
                  index: 0,
                  currentIndex: controller.currentIndex.value),
            ),
            BottomBarItem(
              icon: gradientImageContainer(imagePath: AssetPath.offerIcon,
                  index: 1,
                  currentIndex: controller.currentIndex.value
              ),
              title:  gradientText(text: AppString.offer,
                  index: 1,
                  currentIndex: controller.currentIndex.value),
            ),
            BottomBarItem(
              icon: gradientImageContainer(imagePath: AssetPath.favouriteIcon,
                  index: 2,
                  currentIndex: controller.currentIndex.value),
              title:  gradientText(text: AppString.favourite,
                  index: 2,
                  currentIndex: controller.currentIndex.value),
            ),
            BottomBarItem(
              icon: gradientImageContainer(imagePath: AssetPath.eventIcon,
                  index: 3,
                  currentIndex: controller.currentIndex.value),
              title:  gradientText(text: AppString.schedule,index: 3,
                  currentIndex: controller.currentIndex.value),
            ),
            BottomBarItem(
              icon: gradientImageContainer(imagePath: AssetPath.clubsIcon,
                  index: 4,
                  currentIndex: controller.currentIndex.value),
              title:  gradientText(text: AppString.clubs,index: 4,
                  currentIndex: controller.currentIndex.value),
            ),
            BottomBarItem(
              icon: gradientImageContainer(imagePath: AssetPath.profileIcon,index: 5,
                  currentIndex: controller.currentIndex.value),
              title:  gradientText(text: AppString.profile,
                  index: 5,
                  currentIndex: controller.currentIndex.value),
            ),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
            switch (index) {
              case 0:
               Get.toNamed(AppRoute.homeScreen);
                break;
              case 1:
                Get.toNamed(AppRoute.offerScreen);
                break;
              case 2:
                break;
              case 3:
                break;
              case 4:
                break;
              case 5:
                Get.toNamed(AppRoute.profileScreen);
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }
}

Widget gradientImageContainer({required String imagePath, required int index, required int currentIndex}) {
  bool isSelected = index == currentIndex;

  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOut,
    transform: Matrix4.translationValues(0, isSelected ? -10.h : 0, 0),
    height: 40.h,
    width: 40.w,
    decoration: BoxDecoration(
      gradient: RadialGradient(
        center: Alignment(0.0, 0.0),
        radius: 0.7,
        colors: [AppColors.radialGradiant1, AppColors.radialGradiant2],
        stops: [0.6, 1.0],
      ),
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Image.asset(
        imagePath,
        height: 25.h,
        width: 25.w,
        fit: BoxFit.contain,
      ),
    ),
  );
}


// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Radial Gradient Text <<<<<<<<<<<<<<<<<<<<<<<<<<<//

Widget gradientText({required String text, required int index, required int currentIndex}) {
  bool isSelected = index == currentIndex;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    transform: Matrix4.translationValues(0, isSelected ? -6.h : 0, 0),
    padding: EdgeInsets.only(top: 2.h),
    child: ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 1.2,
        colors: [
          AppColors.radialGradiant1,
          AppColors.radialGradiant2,
        ],
        stops: const [0.0, 1.0],
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontFamily: 'SFPro',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
