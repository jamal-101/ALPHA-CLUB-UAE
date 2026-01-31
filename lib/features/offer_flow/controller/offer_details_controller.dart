// import 'package:get/get.dart';
// import 'package:alpha_club/core/service/api/api_service.dart';
// import 'package:alpha_club/core/service/api/api_enpoint.dart';
// import 'package:alpha_club/core/service/logger/app_logger.dart';
// import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
//
// class OfferDetailsController extends GetxController {
//   Rx<OfferModel?> offerDetails = Rx<OfferModel?>(null);
//   RxBool isLoading = false.obs;
//   String offerId = '';
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Get offer ID from arguments
//     offerId = Get.arguments as String? ?? '';
//     if (offerId.isNotEmpty) {
//       fetchOfferDetails(offerId);
//     }
//   }
//
//   /// Fetch offer details from API
//   Future<void> fetchOfferDetails(String offerId) async {
//     try {
//       isLoading.value = true;
//
//       AppLogger.info(
//         'Fetching offer details for ID: $offerId',
//         tag: 'OFFER_DETAILS',
//       );
//
//       final response = await ApiService.get(
//         '${ApiEndPoint.offerDetails}/$offerId',
//       );
//
//       if (response.isSuccess) {
//         final data = response.data['data'] ?? response.data;
//         offerDetails.value = OfferModel.fromJson(
//           Map<String, dynamic>.from(data),
//         );
//
//         AppLogger.info(
//           'Offer details loaded: ${offerDetails.value?.name}',
//           tag: 'OFFER_DETAILS',
//         );
//       } else {
//         AppLogger.error(
//           'Failed to load offer details: ${response.message}',
//           tag: 'OFFER_DETAILS',
//         );
//         Get.snackbar('Error', 'Failed to load offer details');
//       }
//     } catch (e, stackTrace) {
//       AppLogger.error(
//         'Error fetching offer details',
//         tag: 'OFFER_DETAILS',
//         error: e,
//         stackTrace: stackTrace,
//       );
//       Get.snackbar('Error', 'Something went wrong');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Toggle favourite status
//   Future<void> toggleFavourite() async {
//     if (offerDetails.value == null) return;
//
//     try {
//       final currentStatus = offerDetails.value!.isFavourite;
//
//       // Optimistically update UI
//       offerDetails.value = offerDetails.value!.copyWith(
//         isFavourite: !currentStatus,
//       );
//
//       AppLogger.logUserAction(
//         action: 'Toggle Favourite from Details',
//         data: {
//           'offerId': offerId,
//           'newStatus': !currentStatus,
//         },
//         tag: 'OFFER_DETAILS',
//       );
//
//       // Call API
//       final response = await ApiService.post(
//         '${ApiEndPoint.toggleFavourite}/$offerId',
//       );
//
//       if (response.isSuccess) {
//         AppLogger.info(
//           'Favourite toggled successfully',
//           tag: 'OFFER_DETAILS',
//         );
//       } else {
//         // Revert on failure
//         offerDetails.value = offerDetails.value!.copyWith(
//           isFavourite: currentStatus,
//         );
//         AppLogger.error(
//           'Failed to toggle favourite: ${response.message}',
//           tag: 'OFFER_DETAILS',
//         );
//         Get.snackbar('Error', 'Failed to update favourite');
//       }
//     } catch (e, stackTrace) {
//       AppLogger.error(
//         'Error toggling favourite',
//         tag: 'OFFER_DETAILS',
//         error: e,
//         stackTrace: stackTrace,
//       );
//       // Revert on error
//       if (offerDetails.value != null) {
//         offerDetails.value = offerDetails.value!.copyWith(
//           isFavourite: !offerDetails.value!.isFavourite,
//         );
//       }
//     }
//   }
// }


import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/logger/app_logger.dart';
import '../model/offer_model.dart';

class OfferDetailsController extends GetxController {
  Rx<OfferModel?> offerDetails = Rx<OfferModel?>(null);
  RxBool isLoading = false.obs;

  /// Fetch offer details from API
  Future<void> fetchOfferDetails(String offerId) async {
    try {
      isLoading.value = true;

      AppLogger.info(
        'Fetching offer details for ID: $offerId',
        tag: 'OFFER_DETAILS',
      );

      final response = await ApiService.get(
        '${ApiEndPoint.offerDetails}/$offerId',
      );

      if (response.isSuccess) {
        final data = response.data['data'] ?? response.data;
        offerDetails.value = OfferModel.fromJson(
          Map<String, dynamic>.from(data),
        );
      } else {
        Get.snackbar('Error', response.message ?? 'Failed to load offer');
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error fetching offer details',
        tag: 'OFFER_DETAILS',
        error: e,
        stackTrace: stackTrace,
      );
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle favourite
  Future<void> toggleFavourite(String offerId) async {
    if (offerDetails.value == null) return;

    final currentStatus = offerDetails.value!.isFavourite;

    // optimistic update
    offerDetails.value =
        offerDetails.value!.copyWith(isFavourite: !currentStatus);

    try {
      final response = await ApiService.post(
        '${ApiEndPoint.toggleFavourite}/$offerId',
      );

      if (!response.isSuccess) {
        offerDetails.value =
            offerDetails.value!.copyWith(isFavourite: currentStatus);
      }
    } catch (_) {
      offerDetails.value =
          offerDetails.value!.copyWith(isFavourite: currentStatus);
    }
  }
}
