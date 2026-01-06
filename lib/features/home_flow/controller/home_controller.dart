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
  var singleSponsorDetails = {}.obs;
  var isSponsorLoading = false.obs;
  var isMoreLoading = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;
  var isMoreStoriesLoading = false.obs;
  int currentStoryPage = 1;
  bool hasMoreStories = true;

  @override
  void onInit() {
    super.onInit();
    fetchLatestStories();
    fetchSponsors();
  }




  Future<void> fetchLatestStories({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isMoreStoriesLoading.value = true;
    } else {
      currentStoryPage = 1;
      isLoading.value = true;
      hasMoreStories = true;
    }

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.stories}?page=$currentStoryPage&limit=10",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newStories = responseData['data'] ?? [];

        if (isLoadMore) {
          stories.addAll(newStories);
        } else {
          stories.assignAll(newStories);
        }
        if (newStories.length < 10) {
          hasMoreStories = false;
        } else {
          currentStoryPage++;
          hasMoreStories = true;
        }
      },
    );

    isLoading.value = false;
    isMoreStoriesLoading.value = false;
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

  Future<void> fetchSponsors({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isMoreLoading.value = true;
    } else {
      currentPage = 1;
      isSponsorLoading.value = true;
    }

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.sponsor}?page=$currentPage&limit=3",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];

        if (isLoadMore) {
          sponsors.addAll(newItems);
        } else {
          sponsors.assignAll(newItems);
        }
        if (newItems.length < 3) {
          hasMoreData = false;
        } else {
          currentPage++;
          hasMoreData = true;
        }
      },
    );

    isSponsorLoading.value = false;
    isMoreLoading.value = false;
  }



  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Sponsor Details <<<<<<<<<<<<<<<<<<<<<//

  Future<void> fetchSponsorDetails(String id) async {
    isLoading.value = true;
    singleSponsorDetails.clear();

    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.sponsor}/$id",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        singleSponsorDetails.value = responseData['data'] ?? {};
      },
    );
    isLoading.value = false;
  }
}
