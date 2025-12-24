import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});
  final List<Map<String, String>> faqData = [
    {
      'question': "What is the purpose of the Alpha Club app?",
      'answer': "The Alpha Club app is designed to provide seamless access to exclusive services and real-time tracking.",
    },
    {
      'question': "What backend architecture is recommended?",
      'answer': "A cloud-based backend using Firebase or AWS for scalability, real-time data sync, and secure authentication.",
    },
    {
      'question': "How are keys tracked once dropped off?",
      'answer': "Keys are tracked via a unique digital ID system integrated with our mobile app for real-time updates.",
    },
    {
      'question': "How does PIN system work?",
      'answer': "The PIN system provides a secure, one-time access code generated for each user session.",
    },
  ];

  final RxInt activeIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
           CommonAppBar(title: AppString.faq),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: faqData.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = faqData[index];
                  return Obx(() {
                    bool isOpen = activeIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        activeIndex.value = isOpen ? -1 : index;
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.otpBorderColor,
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CommonText(
                                      textAlign: TextAlign.start,
                                      fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blue1,
                                        text: item['question']!,
                                    )
                                  ),
                                  SizedBox(width: 10.w),
                                  Image.asset(
                                    isOpen
                                        ? AssetPath.minus
                                        : AssetPath.addSquare,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                ],
                              ),
                            ),
                            if (isOpen)
                              Padding(
                                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                                child:  CommonText(
                                  textAlign: TextAlign.start,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blueBase,
                                  text: item['answer']!,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}