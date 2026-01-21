// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../controller/event_controller.dart';
//
//
// class EventStatusButton extends StatelessWidget {
//   EventStatusButton({super.key});
//
//   final EventController eventController = Get.put(EventController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         eventController.toggleEventStatus();
//       },
//       child: Obx(() => Container(
//         decoration: eventController.isRequested.value ? BoxDecoration(
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(color: Colors.white10),
//           gradient: const RadialGradient(
//             center: Alignment.center,
//             radius: 3.0,
//             colors: [
//               Color(0xFF162247),
//               Color(0xFF020A12),
//             ],
//             stops: [0.0, 0.9],
//           ),
//         ) : BoxDecoration(
//           borderRadius: BorderRadius.circular(8.r),
//           color: Color(0xFFFD3D32).withValues(alpha: 0.2),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Text(
//               eventController.isRequested.value ? "Request Event" : "Canceled Event",
//               style: TextStyle(
//                 color: eventController.isRequested.value ? const Color(0xFFD4AF37) : Color(0xFFFD3D32),
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'SFPro',
//               ),
//             ),
//           ),
//         ),
//       )),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../controller/event_controller.dart';
//
// class EventStatusButton extends StatelessWidget {
//   final String eventId;
//   EventStatusButton({super.key, required this.eventId});
//
//   final EventController eventController = Get.put(EventController());
//
//   @override
//   Widget build(BuildContext context) {
//     String status = eventController.joinStatus.value;
//     bool isDisabled = eventController.isButtonDisabled.value;
//     return GestureDetector(
//       onTap: () {
//         if (!eventController.isActionLoading.value &&
//             eventController.joinStatus.value != "confirmed") {
//           eventController.handleButtonClick(eventId);
//         }
//         // if (!eventController.isActionLoading.value &&
//         //     eventController.joinStatus.value != "confirmed") {
//         //   eventController.handleButtonClick(eventId);
//         // }
//       },
//       child: Obx(() {
//         String status = eventController.joinStatus.value;
//         BoxDecoration decoration;
//         String text;
//         Color textColor;
//
//         if (status == "confirmed") {
//           text = "Confirmed Event";
//           textColor = Color(0xFF233A66);
//           decoration = BoxDecoration(
//             borderRadius: BorderRadius.circular(8.r),
//             color: Color(0xFFDFBB0B),
//           );
//         } else if (status == "pending" || status == "cancelled") {
//           text = "Cancel Event";
//           textColor = const Color(0xFFFD3D32);
//           decoration = BoxDecoration(
//             borderRadius: BorderRadius.circular(8.r),
//             color: const Color(0xFFFD3D32).withValues(alpha: 0.2),
//           );
//         } else {
//           text = "Request Event";
//           textColor = const Color(0xFFD4AF37);
//           decoration = BoxDecoration(
//             borderRadius: BorderRadius.circular(8.r),
//             border: Border.all(color: Colors.white10),
//             gradient: const RadialGradient(
//               center: Alignment.center,
//               radius: 3.0,
//               colors: [Color(0xFF162247), Color(0xFF020A12)],
//               stops: [0.0, 0.9],
//             ),
//           );
//         }
//
//         return Container(
//           decoration: decoration,
//           child: Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//             child: Center(
//               child:
//               Text(
//                 text,
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'SFPro',
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controller/event_controller.dart';

class EventStatusButton extends StatelessWidget {
  final String eventId;
  EventStatusButton({super.key, required this.eventId});
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      String status = eventController.joinStatus.value;
      bool isDisabled = eventController.isButtonDisabled.value;

      BoxDecoration decoration;
      String text;
      Color textColor;
      if (status == "confirmed") {
        text = "Confirmed Event";
        textColor = const Color(0xFF233A66);
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xFFDFBB0B),
        );
      } else if (status == "pending" || status == "cancelled") {
        text = "Canceled Event";
        textColor = const Color(0xFFFD3D32);
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xFFFD3D32).withValues(alpha: 0.2),
        );
      } else {
        text = "Request Event";
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
            eventController.isButtonDisabled.value ||
            status == "confirmed")
            ? null
            : () => eventController.handleButtonClick(eventId),
        child: Opacity(
          opacity: (isDisabled || status == "confirmed") ? 0.6 : 1.0,
          child: Container(
            decoration: decoration,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            child: Center(
              child: Text(
                text,
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