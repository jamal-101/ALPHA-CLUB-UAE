// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import '../../../core/service/api/api_enpoint.dart';
// import '../../../core/service/api/api_response.dart';
// import '../../../core/service/api/api_service.dart';
// import '../presentaion/model/guest_model.dart';
//
// class EventController extends GetxController {
//   var eventList = [].obs;
//   var isLoading = false.obs;
//   var isMoreLoading = false.obs;
//   int currentPage = 1;
//   bool hasMoreData = true;
//
//   final TextEditingController eventSearchController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchEvents();
//   }
//
//
//   Future<void> searchEvents(String query) async {
//     if (query.isEmpty) {
//       fetchEvents();
//       return;
//     }
//
//     isLoading.value = true;
//     ApiResponseModel response = await ApiService.get(
//       "${ApiEndPoint.event}?searchTerm=$query",
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         List searchResults = responseData['data'] ?? [];
//         eventList.assignAll(searchResults);
//       },
//     );
//     isLoading.value = false;
//   }
//
//   void filterLocalEvents(String query) {
//     if (query.isEmpty) {
//       fetchEvents();
//     } else {
//       var filtered = eventList.where((event) {
//         return event['name'].toString().toLowerCase().contains(query.toLowerCase());
//       }).toList();
//       eventList.assignAll(filtered);
//     }
//   }
//
//   Future<void> fetchEvents({bool isLoadMore = false}) async {
//     if (isLoadMore) {
//       isMoreLoading.value = true;
//     } else {
//       currentPage = 1;
//       isLoading.value = true;
//       hasMoreData = true;
//     }
//
//     ApiResponseModel response = await ApiService.get(
//       "${ApiEndPoint.event}?page=$currentPage&limit=300",
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         List newItems = responseData['data'] ?? [];
//
//         if (isLoadMore) {
//           eventList.addAll(newItems);
//         } else {
//           eventList.assignAll(newItems);
//         }
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
// //>>>>>>>>>>>>>>>>>>>>>>>> event details <<<<<<<<<<<<<<<<<<<//
//
//   var singleEventDetails = {}.obs;
//   var isEventDetailLoading = false.obs;
//
//   Future<void> fetchEventDetails(String id) async {
//     isEventDetailLoading.value = true;
//     isEventDetailLoading.value = true;
//     singleEventDetails.clear();
//     ApiResponseModel response = await ApiService.get("${ApiEndPoint.event}/$id");
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         singleEventDetails.value = responseData['data'] ?? {};
//         if (singleEventDetails.containsKey('joinStatus')) {
//           joinStatus.value = singleEventDetails['joinStatus'];
//         }
//       },
//     );
//
//     isEventDetailLoading.value = false;
//   }
//
//
//
//   var joinStatus = "ongoing".obs;
//
//   Future<void> handleButtonClick(String eventId, List guests) async {
//     if (joinStatus.value == "ongoing") {
//       await joinEventRequest(eventId, guests);
//     }
//   }
//
//
//
//   var isActionLoading = false.obs;
//
//
//   Future<void> joinEventRequest(String eventId, List guests) async {
//     isActionLoading.value = true;
//     Map<String, dynamic> body = {
//       "event": eventId,
//       "guests": guests,
//     };
//
//     ApiResponseModel response = await ApiService.post(
//       ApiEndPoint.eventRegistration,
//       body: body,
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         joinStatus.value = "pending";
//         // Get.snackbar("Success", responseData['message'] ?? "Registration successful",colorText: Colors.green,backgroundColor: Colors.white);
//       },
//     );
//
//     isActionLoading.value = false;
//   }
//
//
//
//   var guestList = <GuestModel>[].obs;
//
//   void addGuest() {
//     guestList.add(GuestModel());
//   }
//
//   void removeGuest(int index) {
//     guestList.removeAt(index);
//     // if (guestList.isEmpty) {
//     // }
//   }
//
//
//
//   Future<void> submitRegistration(String eventId) async {
//
//     List guestsData = guestList.map((g) => {
//       "name": g.nameController.text,
//       "email": g.emailController.text,
//       "phone": g.phoneController.text,
//     }).toList();
//
//
//     await joinEventRequest(eventId, guestsData);
//
//     if (joinStatus.value == "pending") {
//       guestList.clear();
//       // guestList.assignAll([GuestModel()]);
//       // Get.back();
//       guestList.add(GuestModel());
//       if (Get.isDialogOpen ?? false) {
//         Get.back();
//       }
//     }
//   }
//   }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';
import '../presentaion/model/guest_model.dart';

class EventController extends GetxController {
  var eventList = [].obs;
  var isLoading = false.obs; // প্রথমবার লোড বা রিফ্রেশের জন্য (শিমার দেখানোর উদ্দেশ্যে)
  var isMoreLoading = false.obs; // নিচ থেকে পেজিনেশনের সময় লোডিং

  int currentPage = 1;
  final int limit = 10; // 🟢 প্রতি পেজে ১০টি করে ইভেন্ট
  bool hasMoreData = true;

  late ScrollController scrollController;
  final TextEditingController eventSearchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    fetchEvents(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    eventSearchController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    if (currentScroll >= maxScroll - 150) {
      if (!isMoreLoading.value && hasMoreData && !isLoading.value) {
        fetchEvents(isLoadMore: true);
      }
    }
  }

  Future<void> searchEvents(String query) async {
    if (query.isEmpty) {
      fetchEvents(isRefresh: true);
      return;
    }

    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.event}?searchTerm=$query",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List searchResults = responseData['data'] ?? [];
        eventList.assignAll(searchResults);
      },
    );
    isLoading.value = false;
  }

  // 🟢 Pagination & Shimmer support সহ ফেচ মেথড
  Future<void> fetchEvents({bool isRefresh = false, bool isLoadMore = false}) async {
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
      "${ApiEndPoint.event}?page=$currentPage&limit=$limit",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];

        if (newItems.length < limit) {
          hasMoreData = false;
        }

        if (isRefresh) {
          eventList.assignAll(newItems);
        } else {
          eventList.addAll(newItems);
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

  // >>>>>>>>>>>>>>>>>>>>> event details <<<<<<<<<<<<<<<<<<<//
  var singleEventDetails = {}.obs;
  var isEventDetailLoading = false.obs;

  Future<void> fetchEventDetails(String id) async {
    isEventDetailLoading.value = true;
    singleEventDetails.clear();
    ApiResponseModel response = await ApiService.get("${ApiEndPoint.event}/$id");

    response.handleResponse(
      onSuccess: (responseData) {
        singleEventDetails.value = responseData['data'] ?? {};
        if (singleEventDetails.containsKey('joinStatus')) {
          joinStatus.value = singleEventDetails['joinStatus'];
        }
      },
    );

    isEventDetailLoading.value = false;
  }

  var joinStatus = "ongoing".obs;

  Future<void> handleButtonClick(String eventId, List guests) async {
    if (joinStatus.value == "ongoing") {
      await joinEventRequest(eventId, guests);
    }
  }

  var isActionLoading = false.obs;

  Future<void> joinEventRequest(String eventId, List guests) async {
    isActionLoading.value = true;
    Map<String, dynamic> body = {
      "event": eventId,
      "guests": guests,
    };

    ApiResponseModel response = await ApiService.post(
      ApiEndPoint.eventRegistration,
      body: body,
    );

    response.handleResponse(
      onSuccess: (responseData) {
        joinStatus.value = "pending";
      },
    );

    isActionLoading.value = false;
  }

  var guestList = <GuestModel>[].obs;

  void addGuest() {
    guestList.add(GuestModel());
  }

  void removeGuest(int index) {
    guestList.removeAt(index);
  }

  Future<void> submitRegistration(String eventId) async {
    List guestsData = guestList.map((g) => {
      "name": g.nameController.text,
      "email": g.emailController.text,
      "phone": g.phoneController.text,
    }).toList();

    await joinEventRequest(eventId, guestsData);

    if (joinStatus.value == "pending") {
      guestList.clear();
      guestList.add(GuestModel());
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }
}
