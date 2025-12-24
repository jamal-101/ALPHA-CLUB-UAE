import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              CommonText(
                fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.blue1,
                  text: AppString.exclusiveOffer),
              // CommonText(text: )
            ],
          ),
          Spacer(),
          CommonBottomNabVar(selectedIndex: 1),
        ],
      ),
    );
  }
}
