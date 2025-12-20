import 'package:alpha_club/features/auth_flow/presentation/screen/login_screen.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/sing_in_otp.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/sing_in_verify.dart';
import 'package:alpha_club/features/splash_view/screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String loginScreen = '/loginScreen';
  static String singInVerify = '/singInVerify';
  static String singInOtp = '/singInOtp';

  static List<GetPage> route = [
    GetPage(name: splashScreen, page: ()=>SplashScreen()),
    GetPage(name: loginScreen, page:()=> LoginScreen()),
    GetPage(name: singInVerify, page:()=> SingInVerify()),
    GetPage(name: singInOtp, page: ()=>SingInOtp()),
  ];
}