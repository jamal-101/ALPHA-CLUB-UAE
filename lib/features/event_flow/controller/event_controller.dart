import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';
import '../presentaion/model/guest_model.dart';

class EventController extends GetxController {
  var eventList = [].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;

  final TextEditingController eventSearchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }


  Future<void> searchEvents(String query) async {
    if (query.isEmpty) {
      fetchEvents();
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

  void filterLocalEvents(String query) {
    if (query.isEmpty) {
      fetchEvents();
    } else {
      var filtered = eventList.where((event) {
        return event['name'].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      eventList.assignAll(filtered);
    }
  }

  Future<void> fetchEvents({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isMoreLoading.value = true;
    } else {
      currentPage = 1;
      isLoading.value = true;
      hasMoreData = true;
    }

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.event}?page=$currentPage&limit=70",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];

        if (isLoadMore) {
          eventList.addAll(newItems);
        } else {
          eventList.assignAll(newItems);
        }
        if (newItems.length < 70) {
          hasMoreData = false;
        } else {
          currentPage++;
        }
      },
    );

    isLoading.value = false;
    isMoreLoading.value = false;
  }


//>>>>>>>>>>>>>>>>>>>>>>>> event details <<<<<<<<<<<<<<<<<<<//

  var singleEventDetails = {}.obs;
  var isEventDetailLoading = false.obs;

  Future<void> fetchEventDetails(String id) async {
    isEventDetailLoading.value = true;
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
        Get.snackbar("Success", responseData['message'] ?? "Registration successful",colorText: Colors.green,backgroundColor: Colors.white);
      },
    );

    isActionLoading.value = false;
  }



  var guestList = <GuestModel>[].obs;

  void addGuest() {
    guestList.add(GuestModel());
  }

  void removeGuest(int index) {
    if (guestList.length > 1) {
      guestList.removeAt(index);
    }
  }


  Future<void> submitRegistration(String eventId) async {

    List guestsData = guestList.map((g) => {
      "name": g.nameController.text,
      "email": g.emailController.text,
      "phone": g.phoneController.text,
    }).toList();


    await joinEventRequest(eventId, guestsData);

    if (joinStatus.value == "pending") {
      guestList.assignAll([GuestModel()]);
      Get.back();
    }
  }


  }
