import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:get/get.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var aboutDescription = "".obs;
  var privacyPolicyDescription = "".obs;
  var termsDescription = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
    privacyPolicy();
    termsAndCondition();
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> aboutUs <<<<<<<<<<<<<<<<<<<<<<<<<<<//

  Future<void> fetchAboutUs() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.aboutUs);
    response.handleResponse(
      onSuccess: (responseData) {
        aboutDescription.value = responseData['data']['description'] ?? "";
      },
    );
    isLoading.value = false;
  }


  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> privacyPolicy <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

  Future<void> privacyPolicy() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.privacyPolicy);
    response.handleResponse(
      onSuccess: (responseData) {
        privacyPolicyDescription.value = responseData['data']['description'] ?? "";
      },
    );
    isLoading.value = false;
  }


  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> terms and condition <<<<<<<<<<<<<<<<<<<//

  Future<void> termsAndCondition() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.termsAndCondition);
    response.handleResponse(
      onSuccess: (responseData) {
        termsDescription.value = responseData['data']['description'] ?? "";
      },
    );
    isLoading.value = false;
  }

}