import 'package:flutter/material.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../widget/home_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const CommonBottomNabVar(selectedIndex: 0),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: HomeTabBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}