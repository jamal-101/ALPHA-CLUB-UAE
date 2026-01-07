import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/comparison_list.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/widget/regular_member_ship_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../../../core/global/commont_text.dart';
import '../../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../../core/utils/app_string/app_string.dart';
import '../../widget/comparison_button.dart';
class ComparisonScreen extends StatelessWidget {
      ComparisonScreen({super.key});


  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Obx(() {
              if (profileController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileController.membershipPlans.length,
                itemBuilder: (context, index) {
                  final plan = profileController.membershipPlans[index];
                  return RegularMemberShipWidget(planData: plan);
                },
              );
            }),
            SizedBox(height: 16.h),
            //  // FamilyMembership(),
            // SizedBox(height: 16.h),
            CommonText(
              style: TextStyle(
                fontFamily: 'SFPro',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blue1,
              ),
              text: AppString.featureComparison,
            ),
            SizedBox(height: 16.h),
            ComparisonButton(),
            SizedBox(height: 12.h),
            ComparisonList(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}