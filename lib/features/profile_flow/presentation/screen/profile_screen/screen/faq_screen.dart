import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});


  final ProfileController profileController = Get.put(ProfileController());

  final RxInt activeIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.fetchFaqs();
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blue1,
            size: 20.sp,
          ),
        ),
        title: CommonText(
          text: AppString.faq,
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            color: AppColors.blue1,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
           //  SizedBox(height: 50.h),
           // CommonAppBar(title: AppString.faq,onTap: (){
           //   Get.back();
           // },),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                return RefreshIndicator(
                  color: Color(0xFF233A66),
                  backgroundColor: AppColors.appBackgroundColor,
                  onRefresh: () async {
                    await profileController.fetchFaqs();
                  },
                  child: ListView.builder(
                    itemCount: profileController.faqListData.length,
                    padding: EdgeInsets.zero,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = profileController.faqListData[index];
                      return Obx(() {
                        bool isOpen = activeIndex.value == index;
                        return GestureDetector(
                          onTap: () => activeIndex.value = isOpen ? -1 : index,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0.r),
                              border: Border.all(color: AppColors.otpBorderColor, width: 1.w),
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
                                            text: item['title'] ?? "",
                                          )
                                      ),
                                      SizedBox(width: 10.w),
                                      Image.asset(
                                        isOpen ? AssetPath.minus : AssetPath.addSquare,
                                        height: 20.h, width: 20.w,
                                      ),
                                    ],
                                  ),
                                ),
                                if (isOpen)
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                                    child: HtmlWidget(
                                      item['description'] ?? "",
                                      textStyle: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blueBase,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}