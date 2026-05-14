import 'dart:io';
import 'package:alpha_club/core/service/api/api_enpoint.dart';
import 'package:alpha_club/core/utils/app_color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/route/app_route.dart';
import '../../../core/service/api/api_response.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/logger/app_logger.dart';
import '../../../core/stroge/storage_service.dart';
import '../../auth_flow/controller/login_controller.dart';
import '../model/user_profile_model.dart';



enum Gender { name, email, relation }


class ProfileController extends GetxController {
  var isLoading = false.obs;
  var userProfile = Rxn<UserProfileModel>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAboutUs();
    privacyPolicy();
    termsAndCondition();
    // fetchMembershipPlans();
    // fetchFeatureComparison();
    // fetchAlphaMemberShipPlans();
    // fetchAlphaFamily();
    // fetchFamilyProfile();
    // fetchFaqs();
    //
    fetchAllPlans();

    String token = LocalStorage.token;
    if (token.isNotEmpty && token != "null") {
      fetchFeatureComparison();
      fetchFamilyProfile();
      fetchFaqs();
    }
    else {
      debugPrint("Skipping private API calls: No token available yet.");
    }
  }

  @override
  void onClose() {
    // currentPasswordController.dispose();
    // newPasswordController.dispose();
    // confirmPasswordController.dispose();
    // nameController.dispose();
    // emailController.dispose();
    // addressController.dispose();
    // familyNameController.dispose();
    // familyEmailController.dispose();
    // currentPasswordController.dispose();
    // newPasswordController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
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

  // var membershipPlans = [].obs;
  //
  // Future<void> fetchMembershipPlans() async {
  //   isLoading.value = true;
  //   ApiResponseModel response = await ApiService.get(
  //     ApiEndPoint.memberShipPlan,
  //   );
  //
  //   response.handleResponse(
  //     onSuccess: (responseData) {
  //       membershipPlans.value = responseData['data'] ?? [];
  //     },
  //   );
  //   isLoading.value = false;
  // }

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
    // String token = LocalStorage.token;
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(
      ApiEndPoint.featureComparison,
      header: {
        'Authorization': 'Bearer ${LocalStorage.token}',
        'Content-Type': 'application/json',
      },
    );

    response.handleResponse(
      onSuccess: (responseData) {
        comparisonList.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> alpha <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//


  var combinedPlans = [].obs;
  var selectedMemberType = "Select".obs;
  var selectedMemberTypeCode = "".obs;

  var regularMembershipPlans = [].obs;
  var familyMembershipPlans = [].obs;

  // Future<void> fetchAllPlans() async {
  //   isLoading.value = true;
  //   combinedPlans.clear();
  //   ApiResponseModel res = await ApiService.get(ApiEndPoint.membershipPlan);
  //   res.handleResponse(onSuccess: (data) {
  //     if (data['data'] != null) {
  //       combinedPlans.addAll(data['data']);
  //
  //       if (combinedPlans.isNotEmpty) {
  //         updateSelectedPlan(combinedPlans[0]);
  //       }
  //     }
  //   });
  //   isLoading.value = false;
  // }

  Future<void> fetchAllPlans() async {
    isLoading.value = true;
    combinedPlans.clear();
    regularMembershipPlans.clear();
    familyMembershipPlans.clear();

    ApiResponseModel res = await ApiService.get(ApiEndPoint.membershipPlan);

    res.handleResponse(onSuccess: (data) {
      if (data['data'] != null) {
        List allData = data['data'];
        combinedPlans.addAll(allData);

        // Filtering logic
        for (var plan in allData) {
          if (plan['membershipType'] == "Alpha") {
            regularMembershipPlans.add(plan);
          } else if (plan['membershipType'] == "Alpha_family") {
            familyMembershipPlans.add(plan);
          }
        }

        regularMembershipPlans.refresh();
        familyMembershipPlans.refresh();

        if (combinedPlans.isNotEmpty) {
          updateSelectedPlan(combinedPlans[0]);
        }
      }
    });
    isLoading.value = false;
  }


  void updateSelectedPlan(dynamic plan) {
    if (plan == null) return;
    selectedMemberType.value = plan['title'] ?? "";
    selectedMemberTypeCode.value = plan['membershipType'] ?? "";
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> alpha Information <<<<<<<<<<<<<<<<<<<<<<<//

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  var phoneNumber = "".obs;

  bool validateFields() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneNumber.value.isEmpty) {
      Get.snackbar("Error", "Please fill all the main fields",
          backgroundColor: Colors.deepOrangeAccent, colorText: Colors.white);
      return false;
    }
    return true;
  }

  Future<void> createMembershipApplication() async {
    isLoading.value = true;

    String token = LocalStorage.token;

    Map<String, dynamic> bodyData = {
      "title": "alpha_family",
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
        // savedFamilyMembers.clear();
        // nameController.clear();
        // emailController.clear();
        // addressController.clear();
        // phoneNumber.value = "";
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


  //>>>>>>>>>>>>>>>>>>>>>>>>>> add family member <<<<<<<<<<<<<<<<<//


  var familyList = <Map<String, dynamic>>[].obs;
  var membershipData = <String, dynamic>{}.obs;



  Future<void> fetchFamilyProfile() async {
    try {
      isLoading.value = true;

      ApiResponseModel response = await ApiService.get(
        ApiEndPoint.myProfile,
        header: {
          'Authorization': 'Bearer ${LocalStorage.token}',
          'Content-Type': 'application/json',
        },
      );
      response.handleResponse(
        onSuccess: (responseData) {
          if (responseData['data'] != null) {
            userProfile.value = UserProfileModel.fromJson(responseData['data']);
            final rawData = responseData['data'];
            final appForm = rawData['application_form'] ?? {};
            Map<String, dynamic> combined = {};
            combined.addAll(Map<String, dynamic>.from(appForm));
            combined['name'] = rawData['name'];
            combined['profileImage'] = rawData['profileImage'];
            combined['status'] = rawData['status'];
            membershipData.value = combined;
            profileNameController.text = rawData['name'] ?? "";
          }
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>> new Password controller  <<<<<<<<<<<<<<<<<<<<<<<//




  Future<void> changePassword(context) async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> changePasswordBody = {
      "currentPassword": currentPasswordController.text.trim(),
      "newPassword": newPasswordController.text.trim(),
      "confirmPassword": confirmPasswordController.text.trim(),
    };

    String token = LocalStorage.token;

    ApiResponseModel responseModel = await ApiService.post(
      ApiEndPoint.changePass,
      body: changePasswordBody,
      header: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    isLoading.value = false;
    responseModel.handleResponse(
      onSuccess: (data) {
        Get.snackbar("Success", "Password changed successfully",
            backgroundColor: AppColors.appBackgroundColor, colorText: Colors.green);

        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Navigator.pop(context);
      },
    );
  }



  ///>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FAQ <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//


  var faqListData = <dynamic>[].obs;

  Future<void> fetchFaqs() async {
    // String token = LocalStorage.token;
    isLoading.value = true;
    ApiResponseModel response = await ApiService.get(ApiEndPoint.faq,
      header: {
        'Authorization': 'Bearer ${LocalStorage.token}',
        'Content-Type': 'application/json',
      },
    ); // Endpoint: /faq
    response.handleResponse(
      onSuccess: (responseData) {
        faqListData.value = responseData['data'] ?? [];
      },
    );
    isLoading.value = false;
  }


  ///>>>>>>>>>>>>>>>>>>>>>>>>> fetch update Profile <<<<<<<<<<<<<<<<<<//




  final profileNameController = TextEditingController();
  var selectedImage = Rxn<File>();

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Future<void> updateProfile() async {
  //   if (profileNameController.text.isEmpty && selectedImage.value == null) {
  //     Get.snackbar("Error", "Please change something to update",
  //         backgroundColor: Colors.redAccent, colorText: Colors.white);
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //     Map<String, String> bodyData = {
  //       "name": profileNameController.text.trim(),
  //     };
  //     final response = await ApiService.multipart(
  //       ApiEndPoint.updateProfile,
  //       method: "PATCH",
  //       body: bodyData,
  //       imagePath: selectedImage.value?.path,
  //       imageName: "profileImage",
  //     );
  //
  //     if (response.statusCode == 401) {
  //       handleUnauthorized();
  //       return;
  //     }
  //
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Get.back();
  //       Get.snackbar("Success", "Profile updated request successfully",
  //           backgroundColor: Colors.green, colorText: Colors.white);
  //       fetchFamilyProfile();
  //     } else {
  //       Get.snackbar("Failed", response.data['message'] ?? "Update failed",
  //           backgroundColor: Colors.redAccent, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     AppLogger.error("Update Profile Error", error: e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> updateProfile() async {
    if (profileNameController.text.isEmpty &&
        selectedImage.value == null) {
      Get.snackbar(
        "Error",
        "Please change something to update",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    Map<String, String> bodyData = {
      "name": profileNameController.text.trim(),
    };

    final response = await ApiService.multipart(
      ApiEndPoint.updateProfile,
      method: "PATCH",
      body: bodyData,
      imagePath: selectedImage.value?.path,
      imageName: "profileImage",
    );

    response.handleResponse(
      onSuccess: (data) {
        Get.back();
        Get.snackbar(
          "Success",
          "Profile update request sent successfully",
          backgroundColor: Color(0xFF192948),
          colorText: Color(0xFFFFCB20),
        );
        fetchFamilyProfile();
      },
    );

    isLoading.value = false;
  }


  ///>>>>>>>>>>>>>>>>>>>>>> Contact Us <<<<<<<<<<<<<<<<<///

  // ProfileController এর ভেতরে
  var contactList = [].obs;

  Future<void> fetchContactInfo() async {
    try {
      isLoading.value = true;
      ApiResponseModel response = await ApiService.get("${ApiEndPoint.contactUs}?page=1&limit=300");

      response.handleResponse(
        onSuccess: (responseData) {
          contactList.value = responseData['data'] ?? [];
        },
      );
    } catch (e) {
      debugPrint("Error fetching contact info: $e");
    } finally {
      isLoading.value = false;
    }
  }


}



///>>>>>>>>>>>>>>>>>>>> UnUsedCode <<<<<<<<<<<<<<<<<<<<<<//


// var alphaPlanList = <String, dynamic>{}.obs;
// // var membershipPlans = [].obs;
// var selectedMemberType = "Select".obs;
// var selectedMemberTypeCode = "".obs;


// var alphaPlanList = [].obs;
// var selectedMemberType = "Select".obs;
// var selectedMemberTypeCode = "".obs;
//
// Future<void> fetchAlphaMemberShipPlans() async {
//   isLoading.value = true;
//   String token = LocalStorage.token;
//   ApiResponseModel response = await ApiService.get(
//       ApiEndPoint.alphaPlan,
//     header: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     },
//   );
//
//   response.handleResponse(
//     onSuccess: (responseData) {
//       alphaPlanList.value = responseData['data'] ?? [];
//     },
//   );
//   isLoading.value = false;
// }
//
// void updateSelectedPlan(dynamic plan) {
//   // UI তে দেখানোর জন্য টাইটেল (যেমন: Alpha Family)
//   selectedMemberType.value = plan['title'] ?? "";
//   // ব্যাকএন্ডে পাঠানোর জন্য কোড (যেমন: alpha_family)
//   selectedMemberTypeCode.value = plan['membershipType'] ?? "";
// }
//
// //>>>>>>>>>>>>>>>>>>>>>>>>>>>>> alphaFamily <<<<<<<<<<<<<<<<<<<<<<<//
//
// var alphaFamilyLanList = <String, dynamic>{}.obs;
//
// Future<void> fetchAlphaFamily() async {
//   isLoading.value = true;
//   ApiResponseModel response = await ApiService.get(ApiEndPoint.alphaFamily);
//   response.handleResponse(
//     onSuccess: (responseData) {
//       alphaFamilyLanList.value = responseData['data'] ?? [];
//     },
//   );
//   isLoading.value = false;
// }



// Future<void> fetchAllPlans() async {
//   isLoading.value = true;
//   combinedPlans.clear();
//
//   String token = LocalStorage.token;
//   var headers = {
//     'Authorization': 'Bearer $token',
//     'Content-Type': 'application/json',
//   };
//
//   ApiResponseModel alphaRes = await ApiService.get(ApiEndPoint.alphaPlan, header: headers);
//   ApiResponseModel familyRes = await ApiService.get(ApiEndPoint.alphaFamily, header: headers);
//
//   alphaRes.handleResponse(onSuccess: (data) {
//     if (data['data'] != null) combinedPlans.addAll(data['data']);
//   });
//
//   familyRes.handleResponse(onSuccess: (data) {
//     if (data['data'] != null) combinedPlans.addAll(data['data']);
//   });
//
//   isLoading.value = false;
// }
//
//
// void updateSelectedPlan(dynamic plan) {
//   String rawTitle = plan['title'] ?? "Unknown";
//   selectedMemberType.value = rawTitle.replaceAll('_', ' ').capitalizeFirst!;
//   selectedMemberTypeCode.value = plan['membershipType'] ?? "";
// }

// Future<void> fetchAllPlans() async {
//   try {
//     isLoading.value = true;
//     combinedPlans.clear();
//
//     // String token = LocalStorage.token;
//     var headers = {
//       // 'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//
//     ApiResponseModel alphaRes = await ApiService.get(ApiEndPoint.alphaPlan, header: headers);
//     ApiResponseModel familyRes = await ApiService.get(ApiEndPoint.alphaFamily, header: headers);
//
//     alphaRes.handleResponse(onSuccess: (data) {
//       if (data['data'] != null) combinedPlans.addAll(data['data']);
//     });
//
//     familyRes.handleResponse(onSuccess: (data) {
//       if (data['data'] != null) combinedPlans.addAll(data['data']);
//     });
//
//     if (combinedPlans.isNotEmpty && selectedMemberTypeCode.value.isEmpty) {
//       updateSelectedPlan(combinedPlans[0]);
//     }
//
//   } finally {
//     isLoading.value = false;
//   }
// }


// var combinedPlans = [].obs;
// var selectedMemberType = "Select".obs;
// var selectedMemberTypeCode = "".obs;
//
// Future<void> fetchAllPlans() async {
//
//   try {
//     isLoading.value = true;
//     combinedPlans.clear();
//
//     ApiResponseModel res = await ApiService.get(
//         ApiEndPoint.membershipPlan,
//     );
//
//     res.handleResponse(onSuccess: (data) {
//       if (data['data'] != null) {
//         combinedPlans.addAll(data['data']);
//         if (combinedPlans.isNotEmpty) {
//           updateSelectedPlan(combinedPlans[0]);
//         }
//       }
//     });
//   } catch (e) {
//     debugPrint("Error fetching plans: $e");
//   } finally {
//     isLoading.value = false;
//   }
// }
//
// void updateSelectedPlan(dynamic plan) {
//   if (plan == null) return;
//   String rawTitle = plan['membershipType'] ?? "Unknown";
//   selectedMemberType.value = rawTitle.replaceAll('_', ' ').capitalizeFirst ?? "Unknown";
//   selectedMemberTypeCode.value = plan['membershipType'] ?? "";
// }



// var selectedImage = Rxn<File>();
//
//
//
// Future<void> pickImage() async {
//   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     selectedImage.value = File(pickedFile.path);
//   }
// }
// Future<void> updateProfile() async {
//   if (nameController.text.isEmpty && selectedImage.value == null) {
//     Get.snackbar("Error", "Please change something to update");
//     return;
//   }
//
//   try {
//     isLoading.value = true;
//     Map<String, String> body = {
//       "name": nameController.text.trim(),
//     };
//
//     final response = await ApiService.multipart(
//       ApiEndPoint.updateProfile,
//       method: "PATCH",
//       body: body,
//       imagePath: selectedImage.value?.path,
//       imageName: "profileImage",
//     );
//     if (response.statusCode == 200) {
//       Get.back();
//       Get.snackbar("Success", "Profile updated successfully");
//     } else {
//       Get.snackbar("Failed", response.data['message'] ?? "Update failed");
//     }
//   } catch (e) {
//     AppLogger.error("Update Profile Error", error: e);
//   } finally {
//     isLoading.value = false;
//   }
// }

// Future<void> fetchFamilyProfile() async {
//   try {
//     isLoading.value = true;
//     String token =
//         LocalStorage.preferences?.getString(LocalStorageKeys.token) ??
//             LocalStorage.token;
//     ApiResponseModel response = await ApiService.get(
//       ApiEndPoint.myProfile,
//       header: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//
//     response.handleResponse(
//       onSuccess: (responseData) {
//         if (responseData['data'] != null && responseData['data']['application_form'] != null) {
//           var appForm = responseData['data']['application_form'];
//           membershipData.value = Map<String, dynamic>.from(appForm);
//           membershipData.value = Map<String, dynamic>.from(responseData['data']['application_form']);
//           profileNameController.text = responseData['data']['name'] ?? "";
//         }
//       },
//     );
//   } catch (e) {
//     debugPrint("Error: $e");
//   } finally {
//     isLoading.value = false;
//   }
// }