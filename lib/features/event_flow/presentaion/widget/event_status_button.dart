import 'package:alpha_club/features/event_flow/presentaion/widget/guest_from_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controller/event_controller.dart';
import 'add_guest_dialog.dart';

class EventStatusButton extends StatelessWidget {
  final String eventId;
  EventStatusButton({super.key, required this.eventId});
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      String status = eventController.joinStatus.value;
      // bool isDisabled = eventController.isButtonDisabled.value;

      BoxDecoration decoration;
      String text;
      Color textColor;
      if (status == "confirmed") {
        text = "Booking Confirmed";
        textColor = const Color(0xFF233A66);
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xFFDFBB0B),
        );
      } else if (status == "pending") {
        text = "Pending Request";
        textColor = const Color(0xFFFD3D32);
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xFFFD3D32).withValues(alpha: 0.2),
        );
      }
      else if (status == "cancelled") {
        text = "Cancelled Request";
        textColor = const Color(0xFFFD3D32);
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xFFFD3D32).withValues(alpha: 0.2),
        );
      }
      else {
        text = "Register Here";
        textColor = const Color(0xFFD4AF37);
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white10),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 3.0,
            colors: [Color(0xFF162247), Color(0xFF020A12)],
            stops: [0.0, 0.9],
          ),
        );
      }

      return GestureDetector(
        onTap: (eventController.isActionLoading.value ||
            status == "pending" ||
            status == "confirmed")
            ? null
            : () {
          if (status == "ongoing") {
            Get.dialog(
              Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GuestFormDialog(eventId: eventId),
              ),
              barrierDismissible: true,
            );
          }
        },
        child: Opacity(
          opacity: (status == "confirmed") ? 0.6 : 1.0,
          child: Container(
            decoration: decoration,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Center(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFPro',
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}