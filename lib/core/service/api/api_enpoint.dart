
class ApiEndPoint {
  static const baseUrl =  'http://10.10.7.11:7000/api/v1';
  static const stories = '/stories';
  static const imageBaseUrl = 'http://10.10.7.11:7000';
  static const sponsor = '/sponsor';
  static const event = '/event';
  static const club = '/club';

  // ==================================== Atik =====================================
  static const login = '/auth/login';
  static const category = '/category';
  static const offer = '/exclusive-offer';
  static const toggleFavourite = '/exclusive-offer/favourite'; // /{offerId}
  static const favouriteOffers = '/exclusive-offer/all/favourite';
  static const offerDetails = '/exclusive-offer'; // /{offerId}
  static const myProfile = '/user/my-profile';
}
