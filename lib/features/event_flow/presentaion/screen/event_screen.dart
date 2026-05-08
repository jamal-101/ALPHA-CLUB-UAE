import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/global/custom_search_bar.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/event_flow/controller/event_controller.dart';
import 'package:alpha_club/features/event_flow/presentaion/widget/upcomingEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../common_bottom_nav_bar/presentation/common_bottom_nab_var.dart';


class EventScreen extends StatelessWidget {
      EventScreen({super.key});

  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonBottomNabVar(selectedIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CommonText(
                fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue1,
                  text: AppString.upcomingEvent),
              SizedBox(height: 16.h),
              CustomSearchField(
                controller: eventController.eventSearchController,
                onChanged: (value) {
                  eventController.searchEvents(value);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(child: UpComingEvent()),
            ],
          ),
        ),
      ),
    );
  }
}
