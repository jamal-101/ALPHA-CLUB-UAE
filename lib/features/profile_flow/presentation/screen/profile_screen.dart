import 'package:alpha_club/features/profile_flow/presentation/widget/profile_data_container.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileDataContainer(),
        ],
      ),
    );
  }
}
