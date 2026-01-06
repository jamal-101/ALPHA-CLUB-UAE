import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/offer_flow/model/category_model.dart';
import 'package:alpha_club/features/offer_flow/model/offer_model.dart';

class OfferController extends GetxController {
  RxSet<int> offerIndexes = <int>{}.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingOffers = false.obs;
  RxString selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchOffers();
  }

  bool isOffer(int index) {
    return offerIndexes.contains(index);
  }

  void toggleLove(int index) {
    if (offerIndexes.contains(index)) {
      offerIndexes.remove(index);
    } else {
      offerIndexes.add(index);
    }
  }

  /// Toggle favourite status for an offer
  Future<void> toggleFavourite(String offerId) async {
    try {
      // Optimistically update UI
      final index = offers.indexWhere((offer) => offer.id == offerId);
      if (index != -1) {
        final currentStatus = offers[index].isFavourite;
        offers[index] = offers[index].copyWith(
          isFavourite: !currentStatus,
        );

        AppLogger.logUserAction(
          action: 'Toggle Favourite',
          data: {
            'offerId': offerId,
            'newStatus': !currentStatus,
          },
          tag: 'OFFER_FAVOURITE',
        );

        // Call API
        final response = await ApiService.post(
          '${ApiEndPoint.toggleFavourite}/$offerId',
        );

        if (response.isSuccess) {
          AppLogger.info(
            'Favourite toggled successfully',
            tag: 'OFFER_FAVOURITE',
          );
        } else {
          // Revert on failure
          offers[index] = offers[index].copyWith(
            isFavourite: currentStatus,
          );
          AppLogger.error(
            'Failed to toggle favourite: ${response.message}',
            tag: 'OFFER_FAVOURITE',
          );
          Get.snackbar('Error', 'Failed to update favourite');
        }
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error toggling favourite',
        tag: 'OFFER_FAVOURITE',
        error: e,
        stackTrace: stackTrace,
      );
      // Revert on error
      final index = offers.indexWhere((offer) => offer.id == offerId);
      if (index != -1) {
        offers[index] = offers[index].copyWith(
          isFavourite: !offers[index].isFavourite,
        );
      }
    }
  }

  /// Fetch categories from API
  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      
      AppLogger.info('Fetching categories', tag: 'OFFER_CONTROLLER');

      final response = await ApiService.get(
        '${ApiEndPoint.category}?page=1&limit=50',
      );

      if (response.isSuccess) {
        final categoryResponse = CategoryResponse.fromJson(
          Map<String, dynamic>.from(response.data)
        );
        categories.value = categoryResponse.data;
        
        AppLogger.info(
          'Categories loaded: ${categories.length}',
          tag: 'OFFER_CONTROLLER',
        );
      } else {
        AppLogger.error(
          'Failed to load categories: ${response.message}',
          tag: 'OFFER_CONTROLLER',
        );
        Get.snackbar('Error', 'Failed to load categories');
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching categories',
        tag: 'OFFER_CONTROLLER',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoadingCategories.value = false;
    }
  }

  /// Fetch offers from API
  Future<void> fetchOffers({String? categoryFilter}) async {
    try {
      isLoadingOffers.value = true;
      
      AppLogger.info('Fetching offers', tag: 'OFFER_CONTROLLER');

      String endpoint = ApiEndPoint.offer;
      if (categoryFilter != null && categoryFilter.isNotEmpty) {
        endpoint += '?category=$categoryFilter';
      }

      final response = await ApiService.get(endpoint);

      if (response.isSuccess) {
        final offerResponse = OfferResponse.fromJson(
          Map<String, dynamic>.from(response.data)
        );
        offers.value = offerResponse.data;
        
        AppLogger.info(
          'Offers loaded: ${offers.length}',
          tag: 'OFFER_CONTROLLER',
        );
      } else {
        AppLogger.error(
          'Failed to load offers: ${response.message}',
          tag: 'OFFER_CONTROLLER',
        );
        Get.snackbar('Error', 'Failed to load offers');
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching offers',
        tag: 'OFFER_CONTROLLER',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoadingOffers.value = false;
    }
  }

  /// Select a category and filter offers
  void selectCategory(String categoryName) {
    selectedCategory.value = categoryName;
    AppLogger.logUserAction(
      action: 'Category Selected',
      data: {'category': categoryName},
      tag: 'OFFER_FILTER',
    );
    
    // Fetch offers with category filter
    fetchOffers(categoryFilter: categoryName);
  }

  /// Clear category filter
  void clearCategoryFilter() {
    selectedCategory.value = '';
    AppLogger.logUserAction(
      action: 'Category Filter Cleared',
      tag: 'OFFER_FILTER',
    );
    
    // Fetch all offers
    fetchOffers();
  }
}
