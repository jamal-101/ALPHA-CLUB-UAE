import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
import 'package:alpha_club/features/favorite/model/favourite_offer_model.dart';

class FavouriteController extends GetxController {
  RxList<OfferModel> favouriteOffers = <OfferModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavouriteOffers();
  }

  void refreshData() {
    fetchFavouriteOffers();
  }

  /// Fetch favourite offers from API
  Future<void> fetchFavouriteOffers() async {
    try {
      isLoading.value = true;

      AppLogger.info('Fetching favourite offers', tag: 'FAVOURITE_CONTROLLER');

      final response = await ApiService.get(ApiEndPoint.favouriteOffers);

      if (response.isSuccess) {
        final favouriteResponse = FavouriteOfferResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        // Extract the nested exclusiveOffer from each item
        // favouriteOffers.value = favouriteResponse.data
        //     .map((item) => item.exclusiveOffer)
        //     .toList();

        final List<OfferModel> extractedOffers = favouriteResponse.data
            .map((item) => item.exclusiveOffer)
            .toList();

        favouriteOffers.assignAll(extractedOffers);



        AppLogger.info(
          'Favourite offers loaded: ${favouriteOffers.length}',
          tag: 'FAVOURITE_CONTROLLER',
        );
      } else {
        AppLogger.error(
          'Failed to load favourite offers: ${response.message}',
          tag: 'FAVOURITE_CONTROLLER',
        );
        Get.snackbar('Error', 'Failed to load favourite offers');
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching favourite offers',
        tag: 'FAVOURITE_CONTROLLER',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Remove from favourites
  // Future<void> removeFavourite(String offerId) async {
  //   try {
  //     // Optimistically remove from UI
  //     favouriteOffers.removeWhere((offer) => offer.id == offerId);
  //
  //     AppLogger.logUserAction(
  //       action: 'Remove Favourite',
  //       data: {'offerId': offerId},
  //       tag: 'FAVOURITE',
  //     );
  //
  //     favouriteOffers.removeWhere((offer) => offer.id == offerId);
  //     favouriteOffers.refresh();
  //
  //     // Call API
  //     final response = await ApiService.post(
  //       '${ApiEndPoint.toggleFavourite}/$offerId',
  //     );
  //
  //     if (response.isSuccess) {
  //       AppLogger.info(
  //         'Favourite removed successfully',
  //         tag: 'FAVOURITE',
  //       );
  //     } else {
  //       // Refresh on failure
  //       await fetchFavouriteOffers();
  //       AppLogger.error(
  //         'Failed to remove favourite: ${response.message}',
  //         tag: 'FAVOURITE',
  //       );
  //       Get.snackbar('Error', 'Failed to remove favourite');
  //     }
  //   } catch (e, stackTrace) {
  //     AppLogger.error(
  //       'Error removing favourite',
  //       tag: 'FAVOURITE',
  //       error: e,
  //       stackTrace: stackTrace,
  //     );
  //     // Refresh on error
  //     await fetchFavouriteOffers();
  //   }
  // }


  Future<void> removeFavourite(String offerId) async {
    try {
      favouriteOffers.removeWhere((offer) => offer.id == offerId);
      favouriteOffers.refresh();
      final response = await ApiService.post('${ApiEndPoint.toggleFavourite}/$offerId');

      if (response.isSuccess) {
        AppLogger.info('Removed from favourite: $offerId');
      } else {
        fetchFavouriteOffers();
        Get.snackbar('Error', 'Could not sync with server');
      }
    } catch (e) {
      fetchFavouriteOffers();
    }
  }
}