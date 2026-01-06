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

  Future<void> fetchClubs({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isMoreLoading.value = true;
    } else {
      currentPage = 1;
      isLoading.value = true;
      hasMoreData = true;
    }

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.club}?page=$currentPage&limit=10",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];
        if (isLoadMore) {
          clubList.addAll(newItems);
        } else {
          clubList.assignAll(newItems);
        }

        if (newItems.length < 10) {
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