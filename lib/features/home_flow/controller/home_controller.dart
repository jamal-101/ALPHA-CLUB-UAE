import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';

class HomeController extends GetxController {
  RxSet<int> likeIndexes = <int>{}.obs;
  var baseLikeCount = 567;

  void toggleLike(int index) {
    if (likeIndexes.contains(index)) {
      likeIndexes.remove(index);
    } else {
      likeIndexes.add(index);
    }
  }

  bool isLiked(int index) {
    return likeIndexes.contains(index);
  }

  //>>>>>>>>>>>>>>>>>>>>> stories <<<<<<<<<<<<<<<<<<<<<<<<<<//

  var stories = [].obs;
  var isLoading = false.obs;
  var singleStoryDetails = {}.obs;
  var sponsors = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatestStories();
    fetchSponsors();
  }
  Future<void> fetchLatestStories() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.stories}?page=1&limit=10",
    );
    response.handleResponse(
      onSuccess: (responseData) {
        stories.assignAll(responseData['data'] ?? []);
      },
    );
    isLoading.value = false;
  }


  Future<void> fetchStoryDetails(String id) async {
    isLoading.value = true;
    singleStoryDetails.clear();

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.stories}/$id",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        singleStoryDetails.value = responseData['data'] ?? {};
      },
    );

    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> sponsor method <<<<<<<<<<<<<<<//

  Future<void> fetchSponsors() async {
    isLoading.value = true;

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.sponsor}?page=1&limit=10",
    );

    if (response.isSuccess) {
      print("Sponsor Data Loaded: ${response.data['data']}");
      sponsors.assignAll(response.data['data'] ?? []);
    } else {
      print("Sponsor Error: ${response.message}");
    }

    isLoading.value = false;
  }


}
