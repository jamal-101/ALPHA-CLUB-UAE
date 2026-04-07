import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../core/route/app_route.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/stroge/storage_service.dart';


class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  var unreadCount = 0.obs;
  var isLoading = false.obs;
  var notifications = [].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNotificationLogic();
  }

  Future<void> _initializeNotificationLogic() async {
    await requestPermission();
    await _setupLocalNotifications();

    if (LocalStorage.token.isNotEmpty && LocalStorage.token != "null") {
      updateFCMTokenOnServer();
      refreshNotificationData();
    }


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification Clicked: ${message.data}");
      Get.toNamed(AppRoute.notificationScreen);
    });

    _checkInitialMessage();
  }

  void _handleForegroundMessage(RemoteMessage message) async{
    refreshNotificationData();
    String? token = await FirebaseMessaging.instance.getToken();
    if (message.notification != null) {
      debugPrint("====================================================");
      debugPrint("NEW NOTIFICATION RECEIVED");
      debugPrint("Title: ${message.notification!.title}");
      debugPrint("Message: ${message.notification!.body}");
      debugPrint("FCM Token: $token");
      debugPrint("Data: ${message.data}");
      debugPrint("====================================================");

      _showSystemNotification(
        message.notification!.title ?? '',
        message.notification!.body ?? '',
      );
    }
  }

  void refreshNotificationData() {
    getNotificationCount();
    getNotifications();
  }

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> API Operations <<<<<<<<<<<<<<<<<<<<<<<<<<<<<///

  Future<void> getNotificationCount() async {
    ApiResponseModel response = await ApiService.get(ApiEndPoint.notificationCount);
    response.handleResponse(
      onSuccess: (data) => unreadCount.value = data['data']['count'] ?? 0,
    );
  }


  Future<void> getNotifications() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get("/notification?page=1&limit=100");
    response.handleResponse(
      onSuccess: (data) => notifications.value = data['data'] ?? [],
    );
    isLoading.value = false;
  }

  Future<void> clearNotificationCount() async {
    ApiResponseModel response = await ApiService.post("/notification/clear", body: {});
    response.handleResponse(
      onSuccess: (_) => unreadCount.value = 0,
    );
  }

  Future<void> updateFCMTokenOnServer() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        debugPrint("Updating Token: $token");
        ApiResponseModel response = await ApiService.patch("/user", body: {"fcmToken": token});
        response.handleResponse(
          onSuccess: (_) => debugPrint("FCM Token Updated Successfully"),
        );
      }
    } catch (e) {
      debugPrint("Token Error: $e");
    }
  }

  Future<void> requestPermission() async {

    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true, badge: true, sound: true,
    );


    await _localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('Permission Granted');
    }
  }

  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint("App opened from terminated state via notification");
      Future.delayed(const Duration(seconds: 1), () {
        Get.toNamed(AppRoute.notificationScreen);
      });
    }
  }



  Future<void> onUserLogin() async {
    try {

      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        debugPrint("New Token Generated on Login: $token");
        Map<String, dynamic> body = {"fcmToken": token};
        ApiResponseModel response = await ApiService.patch("/user", body: body);

        response.handleResponse(
          onSuccess: (data) {
            debugPrint("FCM Token Updated Successfully after Login");
            refreshNotificationData();
          },
        );
      }
    } catch (e) {
      debugPrint("Error generating token on login: $e");
    }
  }





  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotification.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {

        debugPrint("Notification Clicked! Payload: ${response.payload}");

        Get.toNamed(AppRoute.notificationScreen);
      },
    );
  }


  Future<void> _showSystemNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotification.show(
      id,
      title,
      body,
      details,
      payload: 'notification_screen',
    );
  }



  Future<void> markAsSeen(String notificationId) async {
    ApiResponseModel response = await ApiService.patch(
        "/notification/$notificationId",
        body: {"seen": true}
    );

    if (response.isSuccess) {
      int index = notifications.indexWhere((n) => n['_id'] == notificationId);
      if (index != -1) {
        notifications[index]['seen'] = true;
        notifications.refresh();
      }
      debugPrint("Notification marked as seen: ${response.message}");
    }
    // else {
    //   Get.snackbar("Error", response.message ?? "Failed to update status");
    // }
  }

  Future<void> deleteNotification(String id) async {
    try {
      final response = await ApiService.delete("/notification/$id");

      if (response.statusCode == 200) {
        notifications.removeWhere((item) => item['_id'] == id);
      }else if(response.statusCode == 403 || response.statusCode == 401){
        Get.toNamed(AppRoute.loginScreen);
      }
    }
    catch (e) {
      print("Delete Error: $e");
    }
  }

}
