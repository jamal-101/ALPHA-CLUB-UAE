import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
import 'package:alpha_club/features/favorite/model/favourite_offer_model.dart';
import '../../../core/stroge/storage_service.dart';
import '../../offer_flow/controller/offer_controller.dart';

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

  Future<void> fetchFavouriteOffers() async {
    try {
      String token = LocalStorage.token;
      isLoading.value = true;

      AppLogger.info('Fetching favourite offers', tag: 'FAVOURITE_CONTROLLER');

      final response = await ApiService.get(ApiEndPoint.favouriteOffers,
        header: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.isSuccess) {
        final favouriteResponse = FavouriteOfferResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );
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

  Future<void> removeFavourite(String offerId) async {
    try {
      favouriteOffers.removeWhere((offer) => offer.id == offerId);
      favouriteOffers.refresh();
      if (Get.isRegistered<OfferController>()) {
        final offerController = Get.find<OfferController>();
        int index = offerController.offers.indexWhere((element) => element.id == offerId);
        if (index != -1) {
          offerController.offers[index] = offerController.offers[index].copyWith(
            isFavourite: false,
          );
          offerController.offers.refresh();
        }
      }

      final response = await ApiService.post(
        '${ApiEndPoint.toggleFavourite}/$offerId',
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
        },
      );

      if (!response.isSuccess) {
        fetchFavouriteOffers();
      }
    } catch (e) {
      AppLogger.error('Error removing favourite: $e');
      fetchFavouriteOffers();
    }
  }
}