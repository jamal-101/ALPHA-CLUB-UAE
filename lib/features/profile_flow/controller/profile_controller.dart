import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/profile_flow/model/user_profile_model.dart';

class ProfileController extends GetxController {
  Rx<UserProfileModel?> userProfile = Rx<UserProfileModel?>(null);
  RxBool isLoading = false.obs;
  RxBool isFamilyListVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  /// Fetch user profile from API
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      AppLogger.info('Fetching user profile', tag: 'PROFILE_CONTROLLER');

      final response = await ApiService.get(ApiEndPoint.myProfile);

      if (response.isSuccess) {
        final profileResponse = UserProfileResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        userProfile.value = profileResponse.data;

        AppLogger.info(
          'User profile loaded: ${userProfile.value?.name}',
          tag: 'PROFILE_CONTROLLER',
        );
      } else {
        AppLogger.error(
          'Failed to load user profile: ${response.message}',
          tag: 'PROFILE_CONTROLLER',
        );
        Get.snackbar('Error', 'Failed to load profile');
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching user profile',
        tag: 'PROFILE_CONTROLLER',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle family list visibility
  void toggleFamilyList() {
    isFamilyListVisible.value = !isFamilyListVisible.value;
  }
}
