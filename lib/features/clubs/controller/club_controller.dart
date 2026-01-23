import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';

class ClubController extends GetxController {
  var clubList = [].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;



  var singleClubDetails = {}.obs;
  var isClubDetailLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClubs();
  }



  final TextEditingController clubSearchController = TextEditingController();

  Future<void> searchClubs(String query) async {
    if (query.isEmpty) {
      fetchClubs();
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
      fetchClubs();
    } else {
      var filtered = clubList.where((event) {
        return event['name'].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      clubList.assignAll(filtered);
    }
  }

  Future<void> fetchClubs({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isMoreLoading.value = true;
    } else {
      currentPage = 1;
      isLoading.value = true;
      hasMoreData = true;
    }

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.club}?page=$currentPage&limit=70",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];
        if (isLoadMore) {
          clubList.addAll(newItems);
        } else {
          clubList.assignAll(newItems);
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




  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Club details <<<<<<<<<<<<<<<<<<<<<<<<<<//

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