class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String? address;
  final String membershipType;
  final String userId;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.address,
    required this.membershipType,
    required this.userId,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {

    final applicationForm = json['application_form'] ?? {};


    return UserProfileModel(

      id: applicationForm['memberShipId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['profileImage'],
      address: applicationForm['address'] ?? json['address'],
      membershipType: json['title'] ?? applicationForm['membershipType'] ?? 'Alpha Member',
      userId: json['_id'] ?? '',
    );
  }

  String getImageUrl(String baseUrl) {
    if (image == null || image!.isEmpty) return '';
    if (image!.startsWith('http')) return image!;
    return '$baseUrl/$image';
  }

  Map<String, dynamic> toJson() {
    return {
      'memberShipId': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'address': address,
      'title': membershipType,
      'userId': userId,
    };
  }

}
class UserProfileResponse {
  final bool success;
  final String message;
  final UserProfileModel data;

  UserProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserProfileModel.fromJson(
        Map<String, dynamic>.from(json['data'] ?? {}),
      ),
    );
  }
}
