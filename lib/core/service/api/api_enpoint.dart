
class ApiEndPoint {
  static const baseUrl =  'http://10.10.7.11:7000/api/v1';
  // static const baseUrl = 'http://92.205.234.176:7000/api/v1';
  static const stories = '/stories';
  // static const imageBaseUrl = 'http://92.205.234.176:7000';
  static const imageBaseUrl = 'http://10.10.7.11:7000';
  static const sponsor = '/sponsor';
  static const event = '/event';
  static const club = '/club';
  static const aboutUs = '/settings/about';
  static const privacyPolicy = '/settings/privacy-policy';
  static const termsAndCondition = '/settings/terms-of-services';
  static const memberShipPlan = '/membership-plan';
  static const featureComparison = '/membership-plan/feature-comparison';
  static const alphaPlan = '/membership-plan/alpha';
  static const alphaFamily = '/membership-plan/alpha_family';
  static const membershipApplication = '/membership-application';
  static const contactForm = '/contact-form';
  static const getAllOffers = '/exclusive-offer/get-all';
  static const changePass = '/auth/change-password';
  static const faq = '/faq';
  static String likeStory(String id) => '/stories/$id/like';
  static String filterOffer(String catId) => '/exclusive-offer?category=$catId';
  static String updateProfile = '/user';
  static const String membershipPlan = "/membership-plan";
  static const String forgetPassword = '/auth/forget-password';
  static const String verifyResetOtp = '/auth/verify-reset-otp';
  static const String resetPassword = '/auth/reset-password';
  static const String eventRegistration = '/event-registration';
  static const String cancelEventRegistration = '/event-registration/cancel';
  static const String notificationCount = '/notification/count';
  static const String clearNotification = '/notification/clear';
  static const String contactUs = '/contact-us';
  // ==================================== Atik =====================================
  static const login = '/auth/login';
  static const category = '/category';
  static const offer = '/exclusive-offer';
  static const toggleFavourite = '/exclusive-offer/favourite'; // /{offerId}
  static const favouriteOffers = '/exclusive-offer/all/favourite';
  static const offerDetails = '/exclusive-offer'; // /{offerId}
  static const myProfile = '/user/my-profile';
}
