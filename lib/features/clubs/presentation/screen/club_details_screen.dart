import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:alpha_club/core/utils/app_image/app_image.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/clubs/controller/club_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/service/api/api_enpoint.dart';

class ClubDetailsScreen extends StatelessWidget {
  final String clubId;

  ClubDetailsScreen({super.key, required this.clubId});

  final ClubController clubController = ClubController();

  @override
  Widget build(BuildContext context) {
    clubController.fetchClubDetails(clubId);

    return Scaffold(
      body: Obx(() {
        final club = clubController.singleClubDetails;

        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        "${ApiEndPoint.imageBaseUrl}${club['image'] ?? ""}",
                        height: 219.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 219.h,
                            width: double.infinity,
                            color: AppColors.otpBorderColor,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 40.sp,
                              color: AppColors.blue1.withValues(alpha: 0.3),
                            ),
                          );
                        },
                        // errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                      ),
                    ),
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColors.gold50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_sharp,
                            size: 22.sp,
                            color: AppColors.blue1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CommonText(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue1,
                  text: club['name'] ?? "",
                ),
                SizedBox(height: 8.h),
                CommonText(
                  style: TextStyle(
                    color: AppColors.blue1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'SFPro',
                  ),
                  text: "${club['limitOfMember'] ?? 0}  Memberships",
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Image.asset(
                      AssetPath.locationIcon,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: CommonText(
                        textAlign: TextAlign.start,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blue1,
                        text: club['location'] ?? "Location not available",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(height: 1, thickness: 0.4, color: Color(0xFFF3F4F6)),
                SizedBox(height: 16.h),
                CommonText(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.blue1,
                  text: AppString.description,
                ),
                SizedBox(height: 16.h),
                HtmlWidget(
                  club['description'] ?? "",
                  textStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: AppColors.blue1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),),
        );
      }),
    );
  }
}
