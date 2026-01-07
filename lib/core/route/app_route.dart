import 'package:alpha_club/features/auth_flow/presentation/screen/login_screen.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/member_form_screen.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/new_password_screen.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/sing_in_otp.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/sing_in_verify.dart';
//import 'package:alpha_club/features/clubs/presentation/screen/club_details_screen.dart';
import 'package:alpha_club/features/clubs/presentation/screen/club_screen.dart';
import 'package:alpha_club/features/clubs/presentation/screen/club_sponsor_screen.dart';
import 'package:alpha_club/features/event_flow/presentaion/screen/event_details_screen.dart';
//import 'package:alpha_club/features/event_flow/presentaion/screen/event_register_screen.dart';
import 'package:alpha_club/features/event_flow/presentaion/screen/event_screen.dart';
import 'package:alpha_club/features/home_flow/presentation/screen/home_screen.dart';
//import 'package:alpha_club/features/home_flow/presentation/widget/latest_stories_details_screen.dart';
import 'package:alpha_club/features/offer_flow/presentation/screen/offer_details_screen.dart';
import 'package:alpha_club/features/offer_flow/presentation/screen/offer_screen.dart';
//import 'package:alpha_club/features/home_flow/presentation/screen/our_sponsor_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/screen/information_details_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/screen/information_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/member_ship/member_ship_screen/member_ship_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/card_details_sponsor_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/edite_profile_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/profile_screen.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/personal_information.dart';
import 'package:alpha_club/features/splash_view/screen/splash_screen.dart';
import 'package:get/get.dart';
//import '../../features/event_flow/presentaion/screen/event_our_sponsor_screen.dart';
import '../../features/favorite/presentation/screen/favorite_screen.dart';

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
  // static String ourSponsorScreen = '/ourSponsorScreen';
  static String offerScreen = '/offerScreen';
  static String offerDetailsScreen = '/offerDetailsScreen';
  static String eventScreen = '/eventScreen';
  // static String eventOurSponsorScreen = '/eventOurSponsorScreen';
  static String eventDetailsScreen = '/eventDetailsScreen';
  static String clubScreen = '/clubScreen';
  // static String clubDetailsScreen = '/clubDetailsScreen';
  static String clubSponsorScreen = '/clubSponsorScreen';
  static String favoriteScreen = '/favoriteScreen';
  static String cardDetailsSponsorScreen = '/cardDetailsSponsorScreen';
  static String memberFormScreen = '/memberFormScreen';
  // static String latestStoriesDetailsScreen = '/latestStoriesDetailsScreen';
  // static String eventRegisterScreen = '/eventRegisterScreen';

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
    // GetPage(name: ourSponsorScreen, page: ()=> OurSponsorScreen()),
    GetPage(name: offerScreen, page: ()=> OfferScreen()),
    GetPage(name: offerDetailsScreen, page: ()=> OfferDetailsScreen()),
    GetPage(name: eventScreen, page: ()=> EventScreen()),
    GetPage(name: eventDetailsScreen, page: ()=> EventDetailsScreen()),
    // GetPage(name: eventOurSponsorScreen, page: ()=> EventOurSponsorScreen()),
    GetPage(name: clubScreen, page: ()=> ClubScreen()),
    // GetPage(name: clubDetailsScreen, page: ()=> ClubDetailsScreen()),
    GetPage(name: clubSponsorScreen, page: ()=> ClubSponsorScreen()),
    GetPage(name: favoriteScreen, page: ()=> FavoriteScreen()),
    GetPage(name: cardDetailsSponsorScreen, page: ()=> CardDetailsSponsorScreen()),
    GetPage(name: memberFormScreen, page: ()=> MemberFormScreen()),
    // GetPage(name: latestStoriesDetailsScreen, page: ()=> LatestStoriesDetailsScreen()),
    // GetPage(name: eventRegisterScreen, page: ()=> EventRegisterScreen()),
  ];
}