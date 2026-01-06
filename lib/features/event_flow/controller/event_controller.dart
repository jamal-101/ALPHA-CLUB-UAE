import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/service/api/api_enpoint.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';

class EventController extends GetxController {
  var eventList = [].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
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
      "${ApiEndPoint.event}?page=$currentPage&limit=3",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        List newItems = responseData['data'] ?? [];

        if (isLoadMore) {
          eventList.addAll(newItems);
        } else {
          eventList.assignAll(newItems);
        }
        if (newItems.length < 3) {
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
    singleEventDetails.clear();
    ApiResponseModel response = await ApiService.get(
      "${ApiEndPoint.event}/$id",
    );

    response.handleResponse(
      onSuccess: (responseData) {
        singleEventDetails.value = responseData['data'] ?? {};
      },
    );

    isEventDetailLoading.value = false;
  }


}