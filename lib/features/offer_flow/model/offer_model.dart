class OfferModel {
  final String id;
  final String name;
  final String title;
  final String image;
  final OfferCategory category;
  final bool isFavourite;

  OfferModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.category,
    required this.isFavourite,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      category: OfferCategory.fromJson(json['category'] ?? {}),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'title': title,
      'image': image,
      'category': category.toJson(),
      'isFavourite': isFavourite,
    };
  }

  // Get full image URL
  String getImageUrl(String baseUrl) {
    if (image.startsWith('http')) {
      return image;
    }
    return '$baseUrl$image';
  }

  // Create a copy with updated favourite status
  OfferModel copyWith({bool? isFavourite}) {
    return OfferModel(
      id: id,
      name: name,
      title: title,
      image: image,
      category: category,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}

class OfferCategory {
  final String id;
  final String name;

  OfferCategory({
    required this.id,
    required this.name,
  });

  factory OfferCategory.fromJson(Map<String, dynamic> json) {
    return OfferCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }

  // Format name for display
  String get displayName {
    return name
        .split('_')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class OfferResponse {
  final bool success;
  final String message;
  final List<OfferModel> data;

  OfferResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // factory OfferResponse.fromJson(Map<String, dynamic> json) {
  //   return OfferResponse(
  //     success: json['success'] ?? false,
  //     message: json['message'] ?? '',
  //     data: (json['pagination'] as List<dynamic>?)
  //         ?.map((item) => OfferModel.fromJson(item))
  //         .toList() ??
  //         [],
  //   );
  // }

  factory OfferResponse.fromJson(Map<String, dynamic> json) {
    return OfferResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => OfferModel.fromJson(item))
          .toList() ??
          [],
    );
  }
}

