import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import '../widget/favorite_gridView_builder.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CommonBottomNabVar(selectedIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              SizedBox(height: 40.h),

              FavoriteGridviewBuilder()
            ],
          ),
        ),
      ),
    );
  }
}
