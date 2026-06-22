import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/profile_flow/model/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/global/commont_text.dart';
import '../../../../../../core/utils/app_color/app_color.dart';
import '../../../../../../core/utils/app_image/app_image.dart';

class ProfileDataContainer extends StatefulWidget {
  final String imagePath;
  final String userName;
  final String membershipType;
  final String userId;
  final bool showBorder;
  final bool showEditButton;
  final bool usePadding;

  const ProfileDataContainer({
    super.key,
    required this.imagePath,
    required this.userName,
    required this.membershipType,
    required this.userId,
    this.showBorder = true,
    this.showEditButton = true,
    this.usePadding = true,
  });

  @override
  State<ProfileDataContainer> createState() => _ProfileDataContainerState();
}

class _ProfileDataContainerState extends State<ProfileDataContainer> {
  UserProfileModel? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      setState(() => isLoading = true);

      AppLogger.info('Fetching user profile', tag: 'PROFILE_DATA');

      final response = await ApiService.get(ApiEndPoint.myProfile);

      if (response.isSuccess) {
        final profileResponse = UserProfileResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        setState(() {
          userProfile = profileResponse.data;
          isLoading = false;
        });

        AppLogger.info(
          'User profile loaded: ${userProfile?.name}',
          tag: 'PROFILE_DATA',
        );
      } else {
        setState(() => isLoading = false);
        AppLogger.error(
          'Failed to load user profile: ${response.message}',
          tag: 'PROFILE_DATA',
        );
      }
    } catch (e, stackTrace) {
      setState(() => isLoading = false);
      AppLogger.error(
        'Error fetching user profile',
        tag: 'PROFILE_DATA',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = userProfile;
    final String rawImagePath =
        profile?.getImageUrl(ApiEndPoint.imageBaseUrl).isNotEmpty == true
        ? profile!.getImageUrl(ApiEndPoint.imageBaseUrl)
        : widget.imagePath;
    final String imagePath = rawImagePath.startsWith('http')
        ? "$rawImagePath?v=${DateTime.now().millisecondsSinceEpoch}"
        : rawImagePath;

    final isNetworkImage = imagePath.startsWith('http');

    return Container(
      height: 130.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: widget.showBorder
            ? Border.all(width: 1.w, color: AppColors.whiteFoundation1)
            : null,
      ),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.goldColor,
                strokeWidth: 2.w,
              ),
            )
          : Padding(
              padding: widget.usePadding
                  ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h)
                  : EdgeInsets.zero,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 110.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        width: 2.w,
                        color: AppColors.goldColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: isNetworkImage
                          ? Image.network(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    AssetPath.profileIcon,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              },
                            )
                          : Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: profile?.name ?? widget.userName,
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            color: const Color(0xFF1A2A4D),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        CommonText(
                          text:
                              profile?.membershipType ?? widget.membershipType,
                          // text: widget.membershipType,
                          style: TextStyle(
                            color: AppColors.goldColor,
                            fontSize: 14.sp,
                          ),
                        ),
                        CommonText(
                          text: profile?.id ?? widget.userId,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.showEditButton)
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(AppRoute.editeProfileScreen);
                        fetchUserProfile();
                      },
                      child: Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.foundation1,
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetPath.editeIcon,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
