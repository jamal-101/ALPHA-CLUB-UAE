import 'package:get/get.dart';
import '../../../../core/service/api/api_response.dart';
import '../../../../core/service/api/api_service.dart';
import '../../../../core/service/api/api_enpoint.dart';
import '../../../core/stroge/storage_service.dart';

class NotificationController extends GetxController {
  var unreadCount = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getNotifications();
    // clearNotificationCount();
    String token = LocalStorage.token;
    if (token.isNotEmpty && token != "null") {
      // fetchFeatureComparison();
      // fetchFamilyProfile();
      // fetchFaqs();
      getNotifications();
      clearNotificationCount();
    }
  }
  Future<void> getNotificationCount() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.notificationCount);

    response.handleResponse(
      onSuccess: (responseData) {
        unreadCount.value = responseData['data']['count'] ?? 0;
      },
    );
    isLoading.value = false;
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> clear notification <<<<<<<<<<<<<<<<<<<<<<<<<<<<<///

  Future<void> clearNotificationCount() async {
    ApiResponseModel response = await ApiService.post("/notification/clear",
        body: {}
    );

    response.handleResponse(
      onSuccess: (responseData) {
        unreadCount.value = 0;
      },
    );
  }


  ///>>>>>>>>>>>>>>>>>>>>>>>>>> get Notification <<<<<<<<<<<<<<<<<<<<<<<<///

  var notifications = [].obs;

  Future<void> getNotifications() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get("/notification?page=1&limit=100");

    response.handleResponse(
      onSuccess: (responseData) {
        notifications.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }

}