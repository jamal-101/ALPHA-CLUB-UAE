// import 'package:get/get.dart';
// import 'package:alpha_club/core/service/api/api_service.dart';
// import 'package:alpha_club/core/service/api/api_enpoint.dart';
// import 'package:alpha_club/core/service/logger/app_logger.dart';
// import 'package:alpha_club/features/offer_flow/model/category_model.dart';
// import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
//
// import '../../favorite/controller/favourite_controller.dart';
//
// class OfferController extends GetxController {
//   RxSet<int> offerIndexes = <int>{}.obs;
//   RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   RxList<OfferModel> offers = <OfferModel>[].obs;
//   RxBool isLoadingCategories = false.obs;
//   RxBool isLoadingOffers = false.obs;
//   RxString selectedCategory = ''.obs;
//
//   var tempSelectedCategoryId = "".obs;
//
//   void updateTempCategory(String id) {
//     tempSelectedCategoryId.value = id;
//   }
//
//   void applyCategoryFilter() {
//     selectedCategory.value = tempSelectedCategoryId.value;
//     fetchOffers();
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//     fetchOffers();
//   }
//
//   bool isOffer(int index) {
//     return offerIndexes.contains(index);
//   }
//
//   void toggleLove(int index) {
//     if (offerIndexes.contains(index)) {
//       offerIndexes.remove(index);
//     } else {
//       offerIndexes.add(index);
//     }
//   }
//
//
//   Future<void> toggleFavourite(String offerId) async {
//     int index = offers.indexWhere((element) => element.id == offerId);
//     if (index != -1) {
//       offers[index] = offers[index].copyWith(
//         isFavourite: !offers[index].isFavourite,
//         // discount: offers[index].discount,
//       );
//       offers.refresh();
//     }
//
//     try {
//       final response = await ApiService.post('${ApiEndPoint.toggleFavourite}/$offerId');
//
//       if (response.isSuccess) {
//         if (Get.isRegistered<FavouriteController>()) {
//           Get.find<FavouriteController>().fetchFavouriteOffers();
//         }
//       } else {
//         if (index != -1) {
//           offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
//           offers.refresh();
//         }
//       }
//     }
//     catch (e) {
//     }
//   }
//
//
//   Future<void> fetchCategories() async {
//     try {
//       isLoadingCategories.value = true;
//
//       AppLogger.info('Fetching categories', tag: 'OFFER_CONTROLLER');
//
//       final response = await ApiService.get(
//         '${ApiEndPoint.category}?page=1&limit=50',
//       );
//
//       if (response.isSuccess) {
//         final categoryResponse = CategoryResponse.fromJson(
//             Map<String, dynamic>.from(response.data)
//         );
//         categories.value = categoryResponse.data;
//
//         AppLogger.info(
//           'Categories loaded: ${categories.length}',
//           tag: 'OFFER_CONTROLLER',
//         );
//       } else {
//         AppLogger.error(
//           'Failed to load categories: ${response.message}',
//           tag: 'OFFER_CONTROLLER',
//         );
//         Get.snackbar('Error', 'Failed to load categories');
//       }
//     } catch (e, stackTrace) {
//       AppLogger.error(
//         'Error fetching categories',
//         tag: 'OFFER_CONTROLLER',
//         error: e,
//         stackTrace: stackTrace,
//       );
//     } finally {
//       isLoadingCategories.value = false;
//     }
//   }
//
//
//   Future<void> fetchOffers({String? categoryId}) async {
//     try {
//       isLoadingOffers.value = true;
//       String effectiveCategory = categoryId ?? selectedCategory.value;
//       String endpoint = "${ApiEndPoint.offer}?page=1&limit=20";
//       if (effectiveCategory.isNotEmpty) {
//         endpoint += '&category=$effectiveCategory';
//       }
//
//       final response = await ApiService.get(endpoint);
//
//       if (response.isSuccess) {
//         final List<dynamic> rawDataList = response.data['data'];
//
//         final List<OfferModel> processedOffers = rawDataList.map((e) {
//           Map<String, dynamic> item = Map<String, dynamic>.from(e);
//           var imageField = item['image'];
//           if (imageField is List && imageField.isNotEmpty) {
//             item['image'] = imageField[0].toString();
//           } else if (imageField is String) {
//             item['image'] = imageField;
//           } else {
//             item['image'] = "";
//           }
//
//           return OfferModel.fromJson(item);
//         }).toList();
//         offers.assignAll(processedOffers);
//
//       } else {
//         Get.snackbar('Error', 'Failed to load offers');
//       }
//     } catch (e, stackTrace) {
//       AppLogger.error('Error fetching offers', error: e, stackTrace: stackTrace);
//     } finally {
//       isLoadingOffers.value = false;
//     }
//   }
//
//   void selectCategory(String categoryId) {
//     selectedCategory.value = categoryId;
//     fetchOffers(categoryId: categoryId);
//   }
//
//
//
//   void clearCategoryFilter() {
//     selectedCategory.value = '';
//     AppLogger.logUserAction(
//       action: 'Category Filter Cleared',
//       tag: 'OFFER_FILTER',
//     );
//     fetchOffers();
//   }
//
//   ///>>>>>>>>>>>>>>>>>>>>>>> filterDistance <<<<<<<<<<<<<<<<<<<<<<//
//
//
//
// }


import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/offer_flow/model/category_model.dart';
import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
import '../../favorite/controller/favourite_controller.dart';

class OfferController extends GetxController {

  RxSet<int> offerIndexes = <int>{}.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingOffers = false.obs;


  RxString selectedCategory = ''.obs;
  RxString selectedMinKm = "".obs;
  RxString selectedMaxKm = "".obs;


  var tempSelectedCategoryId = "".obs;
  var tempMinKm = "".obs;
  var tempMaxKm = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchOffers();
  }



  void toggleDistance(String min, String max) {
    if (tempMinKm.value == min && tempMaxKm.value == max) {
      tempMinKm.value = "";
      tempMaxKm.value = "";
    } else {
      tempMinKm.value = min;
      tempMaxKm.value = max;
    }
  }

  void applyFilters() {
    selectedCategory.value = tempSelectedCategoryId.value;
    selectedMinKm.value = tempMinKm.value;
    selectedMaxKm.value = tempMaxKm.value;

    fetchOffers();
    Get.back();
  }

  void clearAllFilters() {
    selectedCategory.value = '';
    selectedMinKm.value = '';
    selectedMaxKm.value = '';
    tempSelectedCategoryId.value = '';
    tempMinKm.value = '';
    tempMaxKm.value = '';
    fetchOffers();
  }

  // --- API Calls ---

  Future<void> fetchOffers() async {
    try {
      isLoadingOffers.value = true;


      String endpoint = "${ApiEndPoint.offer}?page=1&limit=20";


      if (selectedCategory.value.isNotEmpty) {
        endpoint += '&category=${selectedCategory.value}';
      }

      if (selectedMinKm.value.isNotEmpty && selectedMaxKm.value.isNotEmpty) {
        endpoint += '&minKm=${selectedMinKm.value}&maxKm=${selectedMaxKm.value}';
      }


      endpoint += '&lat=23.801924&lng=90.3523456';

      final response = await ApiService.get(endpoint);

      if (response.isSuccess) {
        final List<dynamic> rawDataList = response.data['data'] ?? [];

        final List<OfferModel> processedOffers = rawDataList.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);

          var imageField = item['image'];
          if (imageField is List && imageField.isNotEmpty) {
            item['image'] = imageField[0].toString();
          } else if (imageField is String) {
            item['image'] = imageField;
          } else {
            item['image'] = "";
          }

          return OfferModel.fromJson(item);
        }).toList();

        offers.assignAll(processedOffers);
      } else {
        Get.snackbar('Error', 'Failed to load offers');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching offers', error: e, stackTrace: stackTrace);
    } finally {
      isLoadingOffers.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final response = await ApiService.get('${ApiEndPoint.category}?page=1&limit=50');

      if (response.isSuccess) {
        final categoryResponse = CategoryResponse.fromJson(Map<String, dynamic>.from(response.data));
        categories.value = categoryResponse.data;
      }
    } catch (e) {
      AppLogger.error('Error fetching categories', error: e);
    } finally {
      isLoadingCategories.value = false;
    }
  }



  Future<void> toggleFavourite(String offerId) async {
    int index = offers.indexWhere((element) => element.id == offerId);
    if (index == -1) return;

    offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
    offers.refresh();

    try {
      final response = await ApiService.post('${ApiEndPoint.toggleFavourite}/$offerId');
      if (response.isSuccess) {
        if (Get.isRegistered<FavouriteController>()) {
          Get.find<FavouriteController>().fetchFavouriteOffers();
        }
      } else {
        offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
        offers.refresh();
      }
    } catch (e) {
      offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
      offers.refresh();
    }
  }
}