// import 'package:get/get.dart';
// import 'package:alpha_club/core/service/api/api_service.dart';
// import 'package:alpha_club/core/service/api/api_enpoint.dart';
// import 'package:alpha_club/core/service/logger/app_logger.dart';
// import 'package:alpha_club/features/offer_flow/model/category_model.dart';
// import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
// import '../../favorite/controller/favourite_controller.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class OfferController extends GetxController {
//
//   RxSet<int> offerIndexes = <int>{}.obs;
//   RxList<CategoryModel> categories = <CategoryModel>[].obs;
//   RxList<OfferModel> offers = <OfferModel>[].obs;
//   RxBool isLoadingCategories = false.obs;
//   RxBool isLoadingOffers = false.obs;
//
//
//   RxString selectedCategory = ''.obs;
//   RxString selectedMinKm = "".obs;
//   RxString selectedMaxKm = "".obs;
//
//
//   var tempSelectedCategoryId = "".obs;
//   var tempMinKm = "".obs;
//   var tempMaxKm = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//     fetchOffers();
//   }
//
//
//
//   void toggleDistance(String min, String max) {
//     if (tempMinKm.value == min && tempMaxKm.value == max) {
//       tempMinKm.value = "";
//       tempMaxKm.value = "";
//     } else {
//       tempMinKm.value = min;
//       tempMaxKm.value = max;
//     }
//   }
//
//   void applyFilters() {
//     selectedCategory.value = tempSelectedCategoryId.value;
//     selectedMinKm.value = tempMinKm.value;
//     selectedMaxKm.value = tempMaxKm.value;
//
//     fetchOffers();
//     Get.back();
//   }
//
//   void clearAllFilters() {
//     selectedCategory.value = '';
//     selectedMinKm.value = '';
//     selectedMaxKm.value = '';
//     tempSelectedCategoryId.value = '';
//     tempMinKm.value = '';
//     tempMaxKm.value = '';
//     fetchOffers();
//   }
//
//   // --- API Calls ---
//
//   Future<void> fetchOffers() async {
//     try {
//       isLoadingOffers.value = true;
//
//
//       String endpoint = "${ApiEndPoint.offer}?page=1&limit=10";
//
//
//       if (selectedCategory.value.isNotEmpty) {
//         endpoint += '&category=${selectedCategory.value}';
//       }
//
//
//       final response = await ApiService.get(endpoint);
//
//       if (response.isSuccess) {
//         final List<dynamic> rawDataList = response.data['data'] ?? [];
//
//         final List<OfferModel> processedOffers = rawDataList.map((e) {
//           Map<String, dynamic> item = Map<String, dynamic>.from(e);
//
//           var imageField = item['image'];
//           if (imageField is List && imageField.isNotEmpty) {
//             item['image'] = imageField[0].toString();
//           } else if (imageField is String) {
//             item['image'] = imageField;
//           } else {
//             item['image'] = "";
//           }
//           return OfferModel.fromJson(item);
//         }).toList();
//
//         offers.assignAll(processedOffers);
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
//   Future<void> fetchCategories() async {
//     try {
//       isLoadingCategories.value = true;
//       final response = await ApiService.get('${ApiEndPoint.category}?page=1&limit=10');
//
//       if (response.isSuccess) {
//         final categoryResponse = CategoryResponse.fromJson(Map<String, dynamic>.from(response.data));
//         categories.value = categoryResponse.data;
//       }
//     } catch (e) {
//       AppLogger.error('Error fetching categories', error: e);
//     } finally {
//       isLoadingCategories.value = false;
//     }
//   }
//
//
//
//   Future<void> toggleFavourite(String offerId) async {
//     int index = offers.indexWhere((element) => element.id == offerId);
//     if (index == -1) return;
//
//     offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
//     offers.refresh();
//
//     try {
//       final response = await ApiService.post('${ApiEndPoint.toggleFavourite}/$offerId');
//       if (response.isSuccess) {
//         if (Get.isRegistered<FavouriteController>()) {
//           Get.find<FavouriteController>().fetchFavouriteOffers();
//         }
//       } else {
//         offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
//         offers.refresh();
//       }
//     } catch (e) {
//       offers[index] = offers[index].copyWith(isFavourite: !offers[index].isFavourite);
//       offers.refresh();
//     }
//   }
//
//   Future<void> openMapNavigation(double? lat, double? lng) async {
//     if (lat == null || lng == null) {
//       Get.snackbar("Error", "Location coordinates not found");
//       return;
//     }
//     final String mapUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
//
//     if (await canLaunchUrl(Uri.parse(mapUrl))) {
//       await launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
//     } else {
//       Get.snackbar("Error", "Could not open maps");
//     }
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_club/core/service/api/api_service.dart';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';
import 'package:alpha_club/features/offer_flow/model/category_model.dart';
import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
import '../../favorite/controller/favourite_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferController extends GetxController {
  RxSet<int> offerIndexes = <int>{}.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;

  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingOffers = false.obs;
  RxBool isMoreDataLoading = false.obs;

  RxString selectedCategory = ''.obs;
  RxString selectedMinKm = "".obs;
  RxString selectedMaxKm = "".obs;

  var tempSelectedCategoryId = "".obs;
  var tempMinKm = "".obs;
  var tempMaxKm = "".obs;

  int currentPage = 1;
  final int limit = 10;
  bool hasMore = true;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    fetchCategories();
    fetchOffers(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }



  void _scrollListener() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    if (currentScroll >= maxScroll - 150) {
      if (!isMoreDataLoading.value && hasMore && !isLoadingOffers.value) {
        fetchMoreOffers();
      }
    }
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

    fetchOffers(isRefresh: true);
    Get.back();
  }

  void clearAllFilters() {
    selectedCategory.value = '';
    selectedMinKm.value = '';
    selectedMaxKm.value = '';
    tempSelectedCategoryId.value = '';
    tempMinKm.value = '';
    tempMaxKm.value = '';
    fetchOffers(isRefresh: true);
  }

  // --- API Calls ---

  Future<void> fetchOffers({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      isLoadingOffers.value = true;
    }

    try {
      String endpoint = "${ApiEndPoint.offer}?page=$currentPage&limit=$limit";

      if (selectedCategory.value.isNotEmpty) {
        endpoint += '&category=${selectedCategory.value}';
      }

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

        if (processedOffers.length < limit) {
          hasMore = false;
        }

        if (isRefresh) {
          offers.assignAll(processedOffers);
        } else {
          offers.addAll(processedOffers);
        }
      } else {
        Get.snackbar('Error', 'Failed to load offers');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching offers', error: e, stackTrace: stackTrace);
    } finally {
      isLoadingOffers.value = false;
    }
  }

  Future<void> fetchMoreOffers() async {
    if (!hasMore) return;
    try {
      isMoreDataLoading.value = true;
      currentPage++;

      String endpoint = "${ApiEndPoint.offer}?page=$currentPage&limit=$limit";
      if (selectedCategory.value.isNotEmpty) {
        endpoint += '&category=${selectedCategory.value}';
      }

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

        if (processedOffers.length < limit) {
          hasMore = false;
        }

        offers.addAll(processedOffers);
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error fetching more offers', error: e, stackTrace: stackTrace);
      currentPage--;
    } finally {
      isMoreDataLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final response = await ApiService.get('${ApiEndPoint.category}?page=1&limit=6');

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

  Future<void> openMapNavigation(double? lat, double? lng) async {
    if (lat == null || lng == null) {
      Get.snackbar("Error", "Location coordinates not found");
      return;
    }
    final String mapUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";

    if (await canLaunchUrl(Uri.parse(mapUrl))) {
      await launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not open maps");
    }
  }
}