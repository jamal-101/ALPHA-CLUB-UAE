import 'package:flutter/material.dart';
import 'package:alpha_club/core/stroge/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'my_app.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'core/route/app_route.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await dotenv.load(fileName: ".env");

  final options = DefaultFirebaseOptions.currentPlatform;
  if (options.apiKey.isNotEmpty && options.appId.isNotEmpty) {
    try {
      await Firebase.initializeApp(options: options);
      debugPrint("Background Message Received: ${message.messageId}");
      String? token = await FirebaseMessaging.instance.getToken();

      debugPrint("📩 [Background Message] Title: ${message.notification?.title}");
      debugPrint("🔑 [Background Token]: $token");
    } catch (e) {
      debugPrint("Failed to initialize Firebase in background: $e");
    }
  } else {
    debugPrint("Firebase options are empty. Skipping background initialization.");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  bool isFirebaseConfigured = false;
  final options = DefaultFirebaseOptions.currentPlatform;
  if (options.apiKey.isNotEmpty && options.appId.isNotEmpty) {
    try {
      await Firebase.initializeApp(options: options);
      isFirebaseConfigured = true;
    } catch (e) {
      debugPrint("Failed to initialize Firebase: $e");
    }
  } else {
    debugPrint("Firebase configuration is empty. Skipping initialization.");
  }

  if (isFirebaseConfigured) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    playSound: true,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);


  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/launcher_icon');

  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      Get.toNamed(AppRoute.notificationScreen);
    },
  );

  if (isFirebaseConfigured) {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  await LocalStorage.init();
  await LocalStorage.getAllPrefData();

  runApp(const MyApp());
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // debugPrint("API KEY: ${dotenv.env['FIREBASE_API_KEY']}");
    // debugPrint("PROJECT ID: ${dotenv.env['FIREBASE_PROJECT_ID']}");
    // debugPrint("MessagingSederId: ${dotenv.env['FIREBASE_MESSAGING_SENDER_ID']}");
    // debugPrint("AppId: ${dotenv.env['FIREBASE_APP_ID']}");
    // debugPrint("StorageBucket: ${dotenv.env['FIREBASE_STORAGE_BUCKET']}");
    if (kIsWeb) throw UnsupportedError('Web not supported');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Platform not configured');
    }
  }
  static FirebaseOptions get android => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
    appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
  );
  static FirebaseOptions get ios => FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
    appId: dotenv.env['FIREBASE_APP_ID'] ?? '',
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '',
    projectId: dotenv.env['FIREBASE_PROJECT_ID'] ?? '',
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '',
    iosBundleId: 'com.alphaclub.app',
  );
}