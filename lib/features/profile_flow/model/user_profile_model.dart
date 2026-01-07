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
    return UserProfileModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'],
      address: json['address'],
      membershipType: json['membershipType'] ?? 'Alpha Member',
      userId: json['userId'] ?? json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'address': address,
      'membershipType': membershipType,
      'userId': userId,
    };
  }

  // Get full image URL
  String getImageUrl(String baseUrl) {
    if (image == null || image!.isEmpty) return '';
    if (image!.startsWith('http')) {
      return image!;
    }
    return '$baseUrl$image';
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
