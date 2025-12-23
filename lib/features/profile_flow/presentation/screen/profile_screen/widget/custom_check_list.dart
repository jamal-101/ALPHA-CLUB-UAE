import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';

class CustomCheckList extends StatelessWidget {
  const CustomCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCustomItem("Access to all Alpha networking events"),
        _buildCustomItem("Exclusive member discounts and offers"),
        _buildCustomItem("Priority event registration"),
        _buildCustomItem("Access to co-working spaces"),
      ],
    );
  }

  Widget _buildCustomItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.check,
            color: AppColors.blue1,
            size: 12,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child:
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [
                  AppColors.linearGradient1,
                  AppColors.linearGradient2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: 'SFPro',
              ),
            ),
          )
        ),
      ],
    );
  }
}