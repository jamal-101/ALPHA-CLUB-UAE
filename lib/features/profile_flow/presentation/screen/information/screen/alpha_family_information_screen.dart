import 'package:alpha_club/core/global/common_app_bar.dart';
import 'package:alpha_club/core/global/common_button.dart';
import 'package:alpha_club/core/global/common_text_field.dart';
import 'package:alpha_club/core/global/commont_text.dart';
import 'package:alpha_club/core/global/custom_phone_field.dart';
import 'package:alpha_club/core/route/app_route.dart';
import 'package:alpha_club/core/utils/app_string/app_string.dart';
import 'package:alpha_club/features/auth_flow/presentation/screen/login_screen.dart';
import 'package:alpha_club/features/profile_flow/controller/profile_controller.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/widget/add_family_continer.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/widget/family_mamber_widget.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/information/widget/sav_family_members.dart';
import 'package:alpha_club/features/profile_flow/presentation/screen/profile_screen/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/app_color/app_color.dart';


class AlphaFamilyInformationScreen extends StatelessWidget {
     AlphaFamilyInformationScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  static final RxBool showField = false.obs;
  static final RxBool saveFamilyMember = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              CommonAppBar(title: AppString.information,onTap: (){
                // ProfileScreen.isFamilyListVisible.value = true;
                Get.toNamed(AppRoute.profileScreen);
              },),
              SizedBox(height: 30.h),
              CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.blue1,
                  ),
                  text: AppString.fullName
              ),
              SizedBox(height: 8.h),
              CommonTextField(
                controller: profileController.nameController,
                isPopins: true,
                containerColor: AppColors.appBackgroundColor,
                hintText: AppString.michealAnderson,
              ),
              SizedBox(height: 16.h),
              CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.blue1,
                  ),
                  text: AppString.contactNumber),
              SizedBox(height: 16.h),
              CustomPhoneField(
                  hintText: "09 -1897243189",
                onNumberChanged: (phone) {
                  debugPrint("Full Number: ${phone.completeNumber}");
                  profileController.phoneNumber.value = phone.completeNumber;
                },
              ),
              CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.blue1,
                  ),
                  text: AppString.email
              ),
              SizedBox(height: 8.h),
              CommonTextField(
                controller: profileController.emailController,
                isPopins: true,
                containerColor: AppColors.appBackgroundColor,
                hintText: AppString.gmail,
              ),
              SizedBox(height: 16.h),
              CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.blue1,
                  ),
                  text: AppString.address
              ),
              SizedBox(height: 8.h),
              CommonTextField(
                controller: profileController.addressController,
                isPopins: true,
                containerColor: AppColors.appBackgroundColor,
                hintText: AppString.location,
              ),
              SizedBox(height: 16.h),
              CommonText(
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.blue1,
                  ),
                  text: AppString.familyMembers
              ),
              Obx(() {
                return Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileController.savedFamilyMembers.length,
                      itemBuilder: (context, index) {
                        var member = profileController.savedFamilyMembers[index];
                        return Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: SavFamilyMembers(
                            name: member['name'] ?? "",
                            email: member['email'] ?? "",
                            relation: member['relation'] ?? "", onDelete: () {
                            profileController.savedFamilyMembers.removeAt(index);
                            Get.snackbar("Removed", "Member removed from the list");
                          },
                          ),
                        );
                      },
                    ),
                    if (showField.value)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: FamilyMemberWidget(),
                      ),
                  ],
                );
              }),
              Obx(()=> showField.value == true ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showField.value = false;
                          },
                          child: Container(
                            height: 38.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.redColor.withValues(alpha: 0.15)
                            ),child: Center(
                              child: CommonText(
                              fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.redColor,
                                text: "Cancel",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            if (profileController.familyNameController.text.isNotEmpty &&
                                profileController.familyEmailController.text.isNotEmpty &&
                                profileController.selectedGender.value != "Select") {

                              profileController.addMemberToList();

                              saveFamilyMember.value = true;
                              showField.value = false;

                              Get.snackbar("Success", "Family member added to list");
                            }
                          },
                          child: Container(
                            height: 38.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.radialGradiant1,
                            ),
                            child: Center(
                              child: CommonText(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.foundationWhite1,
                                text: AppString.save,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ): SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),
                  GestureDetector(
                    onTap: (){
                      showField.value = true;
                    },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: AddFamilyContainer(),
                      )),
                ],
              ),
              SizedBox(height: 10.h),
              CommonButton(onTap: (){
                  profileController.createMembershipApplication();
                ProfileScreen.isFamilyListVisible.value = true;
                LoginScreen.isAppLied.value = false;
              }, text: "Submit"),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}