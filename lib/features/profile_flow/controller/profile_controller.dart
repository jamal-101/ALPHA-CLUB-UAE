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
    fetchMembershipPlans();
    fetchFeatureComparison();
    fetchAlphaMemberShipPlans();
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


  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> MemberShip PLan <<<<<<<<<<<<<<<<<<<<<<<<<<//

  var membershipPlans = [].obs;

  Future<void> fetchMembershipPlans() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.memberShipPlan);

    response.handleResponse(
      onSuccess: (responseData) {
        membershipPlans.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> More Features <<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

  var expandedStates = <String, bool>{}.obs;

  void toggleExpansion(String planId) {
    if (expandedStates.containsKey(planId)) {
      expandedStates[planId] = !expandedStates[planId]!;
    } else {
      expandedStates[planId] = true;
    }
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Comparison List <<<<<<<<<<<<<<<<<<<<<<<<//

  var comparisonList = [].obs;

  Future<void> fetchFeatureComparison() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.featureComparison);

    response.handleResponse(
      onSuccess: (responseData) {
        comparisonList.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> alpha <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//


  var alphaPlanList = <String, dynamic>{}.obs;

  Future<void> fetchAlphaMemberShipPlans() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.alphaPlan);

    response.handleResponse(
      onSuccess: (responseData) {
        alphaPlanList.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>> alphaFamily <<<<<<<<<<<<<<<<<<<<<<<//

  var alphaFamilyLanList = <String, dynamic>{}.obs;

  Future<void> fetchAlphaFamily() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.alphaFamily);
    response.handleResponse(
      onSuccess: (responseData) {
        alphaFamilyLanList.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }




}