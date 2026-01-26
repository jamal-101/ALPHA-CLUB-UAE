import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/stroge/storage_service.dart';
import '../../../core/stroge/stroge_key.dart';

class HomeController extends GetxController {
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
  var sliderIndices = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatestStories();
    fetchSponsors();
  }


  void refreshStories() {
    fetchLatestStories(isLoadMore: false);
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
      "${ApiEndPoint.stories}?page=$currentStoryPage&limit=90",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List rawStories = responseData['data'] ?? [];
        List newStories = List.from(rawStories);
        List<String> savedLikes = LocalStorage.preferences?.getStringList('user_likes') ?? [];
        for (var story in newStories) {
          String id = story['_id'] ?? "";
          bool likedStatus = (story['isLiked'] ?? false) || savedLikes.contains(id);
          int count = story['likeCount'] ?? 0;
          storyIsLiked[id] = likedStatus;
          storyLikesCount[id] = count;
        }
        if (isLoadMore) {
          stories.addAll(newStories);
        } else {
          stories.assignAll(newStories);
        }
        if (newStories.length < 90) {
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
      "${ApiEndPoint.sponsor}?page=$currentPage&limit=90",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];

        if (isLoadMore) {
          sponsors.addAll(newItems);
        } else {
          sponsors.assignAll(newItems);
        }
        if (newItems.length < 90) {
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

  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> like update <<<<<<<<<<<<<<<<<<<<///

  var storyLikesCount = <String, int>{}.obs;
  var storyIsLiked = <String, bool>{}.obs;

  Future<void> toggleLikeStory(String storyId) async {
    String token =
        LocalStorage.preferences?.getString(LocalStorageKeys.token) ??
        LocalStorage.token;
    String url = ApiEndPoint.likeStory(storyId);

    ApiResponseModel response = await ApiService.post(
      url,
      header: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    response.handleResponse(
      onSuccess: (responseData) {
        bool isLiked = responseData['data']['liked'] ?? false;
        int likeCount = responseData['data']['likeCount'] ?? 0;
        storyIsLiked[storyId] = isLiked;
        storyLikesCount[storyId] = likeCount;
        List<String> myLikes =
            LocalStorage.preferences?.getStringList('user_likes') ?? [];

        if (isLiked) {
          if (!myLikes.contains(storyId)) myLikes.add(storyId);
        } else {
          myLikes.remove(storyId);
        }
        LocalStorage.preferences?.setStringList('user_likes', myLikes);
      },
    );
  }
}
