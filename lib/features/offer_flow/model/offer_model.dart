class OfferModel {
  final String id;
  final String name;
  final String title;
  final String image;
  final OfferCategory category;
  final bool isFavourite;
  final Discount? discount;
  final String description;

  OfferModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.category,
    required this.isFavourite,
    required this.description,
    this.discount,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] is List && (json['image'] as List).isNotEmpty
          ? (json['image'] as List).first.toString()
          : (json['image']?.toString() ?? ''),
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : Discount(enable: false, value: 0),
      description: json['description'] ?? '',
      category: OfferCategory.fromJson(json['category'] ?? {}),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  String getImageUrl(String baseUrl) {
    if (image.isEmpty) return "";
    if (image.startsWith('http')) return image;
    return '$baseUrl$image';
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'title': title,
      'description': description,
      'image': image,
      'category': category.toJson(),
      'isFavourite': isFavourite,
      'discount': discount?.toJson(),
    };
  }

  OfferModel copyWith({
    bool? isFavourite,
    Discount? discount,
    String? name,
    String? title,
    OfferCategory? category,
  }) {
    return OfferModel(
      id: id,
      name: name ?? this.name,
      title: title ?? this.title,
      image: image,
      description: description,
      category: category ?? this.category,
      isFavourite: isFavourite ?? this.isFavourite,
      discount: discount ?? this.discount,
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
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
  String get displayName {
    if (name.isEmpty) return "";
    return name
        .split('_')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Discount {
  final bool enable;
  final int value;

  Discount({required this.enable, required this.value});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      enable: json['enable'] ?? false,
      value: (json['value'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enable': enable,
      'value': value,
    };
  }
}
