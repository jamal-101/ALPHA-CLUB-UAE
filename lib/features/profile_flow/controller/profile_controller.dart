import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/route/app_route.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/stroge/storage_service.dart';
import '../../auth_flow/presentation/screen/login_screen.dart';
import '../presentation/screen/profile_screen/screen/profile_screen.dart';

enum Gender { name, email, relation }


class ProfileController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
    privacyPolicy();
    termsAndCondition();
    fetchMembershipPlans();
    fetchFeatureComparison();
    fetchAlphaMemberShipPlans();
    fetchAlphaFamily();
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> aboutUs <<<<<<<<<<<<<<<<<<<<<<<<<<<//
  var aboutDescription = "".obs;

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
  var privacyPolicyDescription = "".obs;

  Future<void> privacyPolicy() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.privacyPolicy);
    response.handleResponse(
      onSuccess: (responseData) {
        privacyPolicyDescription.value =
            responseData['data']['description'] ?? "";
      },
    );
    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> terms and condition <<<<<<<<<<<<<<<<<<<//

  var termsDescription = "".obs;

  Future<void> termsAndCondition() async {
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(
      ApiEndPoint.termsAndCondition,
    );
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
    ApiResponseModel response = await ApiService.get(
      ApiEndPoint.memberShipPlan,
    );

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
    ApiResponseModel response = await ApiService.get(
      ApiEndPoint.featureComparison,
    );

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

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> alpha Information <<<<<<<<<<<<<<<<<<<<<<<//

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  var phoneNumber = "".obs;

  Future<void> createMembershipApplication() async {
    isLoading.value = true;

    String token = LocalStorage.token;

    Map<String, dynamic> bodyData = {
      "membershipType": "alpha_family",
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneNumber.value,
      "address": addressController.text.trim(),
      "familyMembers": savedFamilyMembers.map((member) => {
        "name": member["name"],
        "email": member["email"]?.trim(),
        "relation": member["relation"],
      }).toList()
    };

    ApiResponseModel response = await ApiService.post(
      ApiEndPoint.membershipApplication,
      body: bodyData,
      header: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    response.handleResponse(
      onSuccess: (responseData) {
        Get.snackbar("Success", "Application submitted successfully");
        savedFamilyMembers.clear();
        Get.toNamed(AppRoute.profileScreen);
      },
    );
    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>> dropDown <<<<<<<<<<<<<<<<<<<<<<//


  var savedFamilyMembers = <Map<String, String>>[].obs;

  RxString selectedGender = "Select".obs;


  void updateSelectedGender(Gender genderItem) {
    switch (genderItem) {
      case Gender.name:
        selectedGender.value = "spouse";
        break;
      case Gender.email:
        selectedGender.value = "child";
        break;
      case Gender.relation:
        selectedGender.value = "parent";
        break;
    }
  }

  void removeMemberFromList(int index) {
    savedFamilyMembers.removeAt(index);
  }

  final familyNameController = TextEditingController();
  final familyEmailController = TextEditingController();
  void addMemberToList() {
    String relationToSend = selectedGender.value.toLowerCase();
    if (relationToSend == "spouse" || relationToSend == "child") {
      relationToSend = "parent";
    }

    savedFamilyMembers.add({
      "name": familyNameController.text.trim(),
      "email": familyEmailController.text.trim(),
      "relation": relationToSend,
    });

  }

}

