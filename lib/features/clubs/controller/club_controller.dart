// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../../../core/service/api/api_enpoint.dart';
// import '../../../core/service/api/api_response.dart';
// import '../../../core/service/api/api_service.dart';
//
// class ClubController extends GetxController {
//   var clubList = [].obs;
//   var isLoading = false.obs;
//   var isMoreLoading = false.obs;
//   int currentPage = 1;
//   bool hasMoreData = true;
//
//
//
//   var singleClubDetails = {}.obs;
//   var isClubDetailLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchClubs();
//   }
//
//
//
//   final TextEditingController clubSearchController = TextEditingController();
//
//   Future<void> searchClubs(String query) async {
//     if (query.isEmpty) {
//       fetchClubs();
//       return;
//     }
//     isLoading.value = true;
//
//
//     ApiResponseModel response = await ApiService.get(
//       "${ApiEndPoint.club}?searchTerm=$query",
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         List searchResults = responseData['data'] ?? [];
//         clubList.assignAll(searchResults);
//       },
//     );
//
//     isLoading.value = false;
//   }
//
//
//   void filterLocalEvents(String query) {
//     if (query.isEmpty) {
//       fetchClubs();
//     } else {
//       var filtered = clubList.where((event) {
//         return event['name'].toString().toLowerCase().contains(query.toLowerCase());
//       }).toList();
//       clubList.assignAll(filtered);
//     }
//   }
//
//   Future<void> fetchClubs({bool isLoadMore = false}) async {
//     if (isLoadMore) {
//       isMoreLoading.value = true;
//     } else {
//       currentPage = 1;
//       isLoading.value = true;
//       hasMoreData = true;
//     }
//
//     ApiResponseModel response = await ApiService.get(
//       "${ApiEndPoint.club}?page=$currentPage&limit=300",
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         List newItems = responseData['data'] ?? [];
//         if (isLoadMore) {
//           clubList.addAll(newItems);
//         } else {
//           clubList.assignAll(newItems);
//         }
//
//         if (newItems.length < 300) {
//           hasMoreData = false;
//         } else {
//           currentPage++;
//         }
//       },
//     );
//
//     isLoading.value = false;
//     isMoreLoading.value = false;
//   }
//
//
//
//
//   //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Club details <<<<<<<<<<<<<<<<<<<<<<<<<<//
//
//   Future<void> fetchClubDetails(String id) async {
//     isClubDetailLoading.value = true;
//     singleClubDetails.clear();
//
//     ApiResponseModel response = await ApiService.get(
//       "${ApiEndPoint.club}/$id",
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         singleClubDetails.value = responseData['data'] ?? {};
//       },
//     );
//
//     isClubDetailLoading.value = false;
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';

class ClubController extends GetxController {
  var clubList = [].obs;
  var isLoading = false.obs; // প্রথমবার লোড ও রিফ্রেশে শিমার দেখানোর জন্য
  var isMoreLoading = false.obs; // নিচ থেকে পেজিনেশনের সময় লোডিং

  int currentPage = 1;
  final int limit = 10; // 🟢 প্রতি পেজে ১০টি করে ক্লাব
  bool hasMoreData = true;

  late ScrollController scrollController;
  final TextEditingController clubSearchController = TextEditingController();

  var singleClubDetails = {}.obs;
  var isClubDetailLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    fetchClubs(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    clubSearchController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    if (currentScroll >= maxScroll - 150) {
      if (!isMoreLoading.value && hasMoreData && !isLoading.value) {
        fetchClubs(isLoadMore: true);
      }
    }
  }

  Future<void> searchClubs(String query) async {
    if (query.isEmpty) {
      fetchClubs(isRefresh: true);
      return;
    }
    isLoading.value = true;

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.club}?searchTerm=$query",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List searchResults = responseData['data'] ?? [];
        clubList.assignAll(searchResults);
      },
    );

    isLoading.value = false;
  }

  void filterLocalEvents(String query) {
    if (query.isEmpty) {
      fetchClubs(isRefresh: true);
    } else {
      var filtered = clubList.where((event) {
        return event['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
      clubList.assignAll(filtered);
    }
  }

  // 🟢 Pagination & Shimmer support সহ ফেচ মেথড
  Future<void> fetchClubs({bool isRefresh = false, bool isLoadMore = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMoreData = true;
      isLoading.value = true; // শিমার দেখানোর জন্য
    }

    if (isLoadMore) {
      if (!hasMoreData) return;
      isMoreLoading.value = true;
    }

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.club}?page=$currentPage&limit=$limit",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];

        if (newItems.length < limit) {
          hasMoreData = false;
        }

        if (isRefresh) {
          clubList.assignAll(newItems);
        } else {
          clubList.addAll(newItems);
        }

        if (newItems.isNotEmpty && isLoadMore) {
          currentPage++;
        } else if (isRefresh && newItems.isNotEmpty) {
          currentPage = 2; // পরবর্তী পেজের জন্য প্রস্তুত
        }
      },
    );

    isLoading.value = false;
    isMoreLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>> Club details <<<<<<<<<<<<<<<<<<<<<<<<<<//

  Future<void> fetchClubDetails(String id) async {
    isClubDetailLoading.value = true;
    singleClubDetails.clear();

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.club}/$id",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        singleClubDetails.value = responseData['data'] ?? {};
      },
    );

    isClubDetailLoading.value = false;
  }
}