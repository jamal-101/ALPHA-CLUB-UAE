import 'package:alpha_club/features/auth_flow/presentation/screen/login_screen.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/new_password_screen.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/sing_in_otp.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/sing_in_verify.dart';
import 'package:alpha_club/features/home_flow/presentation/screen/home_screen.dart';
import 'package:alpha_club/features/home_flow/presentation/screen/offer_screen.dart';
import 'package:alpha_club/features/home_flow/presentation/screen/our_sponsor_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/screen/information_details_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/screen/information_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/member_ship_screen/member_ship_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/edite_profile_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/profile_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/personal_information.dart';
import 'package:alpha_club/features/splash_view/screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashScreen = '/splashScreen';
  static String loginScreen = '/loginScreen';
  static String singInVerify = '/singInVerify';
  static String singInOtp = '/singInOtp';
  static String newPasswordScreen = '/newPasswordScreen';
  static String profileScreen = '/profileScreen';
  static String memberShipScreen = '/memberShipScreen';
  static String informationScreen = '/informationScreen';
  static String informationDetailsScreen = '/informationDetailsScreen';
  static String personalInformation = '/personalInformation';
  static String editeProfileScreen = '/editeProfileScreen';
  static String homeScreen = '/homeScreen';
  static String ourSponsorScreen = '/ourSponsorScreen';
  static String offerScreen = '/offerScreen';

  static List<GetPage> route = [
    GetPage(name: splashScreen, page: ()=>SplashScreen()),
    GetPage(name: loginScreen, page:()=> LoginScreen()),
    GetPage(name: singInVerify, page:()=> SingInVerify()),
    GetPage(name: singInOtp, page: ()=>SingInOtp()),
    GetPage(name: newPasswordScreen, page: ()=>NewPasswordScreen()),
    GetPage(name: profileScreen, page: ()=>ProfileScreen()),
    GetPage(name: memberShipScreen, page: ()=>MemberShipScreen()),
    GetPage(name: informationScreen, page: ()=>InformationScreen()),
    GetPage(name: informationDetailsScreen, page: ()=>InformationDetailsScreen()),
    GetPage(name: personalInformation, page: ()=> PersonalInformation()),
    GetPage(name: editeProfileScreen, page: ()=> EditeProfileScreen()),
    GetPage(name: homeScreen, page: ()=> HomeScreen()),
    GetPage(name: ourSponsorScreen, page: ()=> OurSponsorScreen()),
    GetPage(name: offerScreen, page: ()=> OfferScreen()),
  ];
}