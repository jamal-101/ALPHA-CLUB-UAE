import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
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
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.appBackgroundColor, // 🔹 Top border color
              width: 1,             // 🔹 Border width
            ),
          ),
        ),
        child: StylishBottomBar(
          elevation: 0,
          option: AnimatedBarOptions(
            iconSize: 28,
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
          ),
          backgroundColor: AppColors.appBackgroundColor,
          items: [
            BottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedColor: Colors.yellow,
              unSelectedColor: Colors.yellow.withOpacity(0.5),
            ),
            BottomBarItem(
              icon: const Icon(Icons.percent),
              title: const Text(
                'Discount',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedColor: Colors.yellow,
            ),
            BottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text(
                'Favorite',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedColor: Colors.yellow,
            ),
            BottomBarItem(
              icon: const Icon(Icons.calendar_month),
              title: const Text(
                'Schedule',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedColor: Colors.yellow,
            ),
            BottomBarItem(
              icon: const Icon(Icons.person_outline),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedColor: Colors.yellow,
            ),
          ],
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.changeIndex(index);
          },
        ),
      ),
    );
  }
}
