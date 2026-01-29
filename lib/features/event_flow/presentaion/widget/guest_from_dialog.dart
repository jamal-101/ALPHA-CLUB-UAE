import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/features/event_flow/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../core/global/custom_phone_field.dart';
import '../../../../core/helper/from_validation.dart';

class GuestFormDialog extends StatelessWidget {
  final String eventId;
  GuestFormDialog({super.key, required this.eventId});


  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.cancel_outlined, color: Color(0xFF233A66)),
                onPressed: () => Get.back(),
              ),
            ),
            Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eventController.guestList.length,
              itemBuilder: (context, index) => _buildGuestCard(index),
            )),

            SizedBox(height: 16.h),

            // OutlinedButton.icon(
            //   onPressed: () => eventController.addGuest(),
            //   icon: const Icon(Icons.add, color: Color(0xFFD4AF37)),
            //   label: const Text("Add guest", style: TextStyle(color: Color(0xFFD4AF37))),
            //   style: OutlinedButton.styleFrom(
            //     minimumSize: Size(double.infinity, 45.h),
            //     side: const BorderSide(color: Color(0xFFD4AF37)),
            //   ),
            // ),

            GestureDetector(
              onTap: (){
                eventController.addGuest();
              },
              child: Container(
                height: 46.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    width: 1.w,
                    color: Color(0xFFD7A859),
                  )
                ),child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Color(0xFFD4AF37)),
                    Text("Add guest", style: TextStyle(color: Color(0xFFD4AF37))),
                  ],
                ),
              ),
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 46.h,
                      width: 128.w,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE4E1),
                        borderRadius: BorderRadius.circular(8.r)
                      ),child: Center(child: CommonText(text: "Cancel",fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFFFD3D32),)),
                    ),
                  )
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      eventController.submitRegistration(eventId);
                      if (Get.isDialogOpen ?? false) {
                        Get.back();
                      }
                    },
                    child: Container(
                      height: 46.h,
                      width: 128.w,
                      decoration: BoxDecoration(
                          color: Color(0xFF233A66),
                          borderRadius: BorderRadius.circular(8.r)
                      ),child: Center(child: CommonText(text: "Save",fontWeight: FontWeight.w400,fontSize: 16.sp,color: Color(0xFFE9EBF0),)),
                    ),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestCard(int index) {
    var guest = eventController.guestList[index];
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Guest: ${index + 1 < 10 ? '0' : ''}${index + 1}",
                  style: const TextStyle(color: Color(0xFF099F2A), fontWeight: FontWeight.w400,fontSize: 18)),
              if (index >= 0)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => eventController.removeGuest(index),
                )
            ],
          ),
          _inputField("Full Name", "Enter Full Name", guest.nameController),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Contact Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Color(0xFF233A66))),
              SizedBox(height: 12.h),
              CustomPhoneField(
                validator: FormValidation.validatePhoneNumber,
                hintText: "09 -1897243189",
                onNumberChanged: (phone) {
                  guest.phoneController.text = phone.completeNumber;
                  debugPrint("Guest $index Phone: ${phone.completeNumber}");
                },
              ),
            ],
          ),
          _inputField("Email", "Enter Email Address", guest.emailController),
        ],
      ),
    );
  }

  Widget _inputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Color(0xFF233A66))),
        SizedBox(height: 12.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4F6185)
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFF1F1F1), width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}