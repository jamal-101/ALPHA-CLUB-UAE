import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_string/app_string.dart';
import '../../../../controller/profile_controller.dart';


class MemberShipInfoContainer extends StatelessWidget {
  MemberShipInfoContainer({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      final data = controller.membershipData;

      return Container(
        width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: AppColors.otpBorderColor,
        ),
      ),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            children: [
              _infoRow(AppString.memberID, data['memberShipId']?.toString() ?? "N/A"),
              // _infoRow(AppString.memberID, data['memberShipId']?.toString() ?? "N/A"),
              SizedBox(height: 10.h),
              _infoRow(AppString.memberShipType,
                  data['membershipType']?.toString().replaceAll('_', ' ').capitalizeFirst ?? "N/A"),
              SizedBox(height: 10.h),
              _infoRow(
                  AppString.memberSince,
                  formatDate(data['createdAt']?.toString()),
              ),
              SizedBox(height: 10.h),
              _infoRow(AppString.expires,
                formatDate(data['expireId']?.toString())),
            ],
          ),
        ),
      );
    });
  }
}

Widget _infoRow(String title, String value) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 14.sp,
            color: AppColors.blue1,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      CommonText(
        text: " : ",
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.blue1,
      ),
      Expanded(
        flex: 3,
        child: Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontSize: 14.sp,
            color: AppColors.blue1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}



String formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty || dateStr == "N/A") return "N/A";
  try {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('d MMMM yyyy').format(dateTime);
  } catch (e) {
    return "N/A";
  }
}
