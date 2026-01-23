class OfferModel {
  final String id;
  final String name;
  final String title;
  // final String image;
  final List<String> images;
  final OfferCategory category;
  final bool isFavourite;
  final Discount? discount;
  final String description;
  final String address;

  OfferModel({
    required this.id,
    required this.name,
    required this.title,
    required this.images,
    required this.category,
    required this.isFavourite,
    required this.description,
    required this.address,
    this.discount,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {

    List<String> imageList = [];
    if (json['image'] is List) {
      imageList = List<String>.from(json['image'].map((x) => x.toString()));
    } else if (json['image'] != null && json['image'].toString().isNotEmpty) {
      imageList = [json['image'].toString()];
    }

    return OfferModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      address: json['address']?.toString() ?? 'No address found',
      // image: json['image'] is List && (json['image'] as List).isNotEmpty
      //     ? (json['image'] as List).first.toString()
      //     : (json['image']?.toString() ?? ''),
      images: imageList,
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : Discount(enable: false, value: 0),
      description: json['description'] ?? '',
      category: OfferCategory.fromJson(json['category'] ?? {}),
      isFavourite: json['isFavourite'] ?? false,
    );
  }

  // String getImageUrl(String baseUrl) {
  //   if (image.isEmpty) return "";
  //   if (image.startsWith('http')) return image;
  //   return '$baseUrl$image';
  // }

  List<String> getAllImageUrls(String baseUrl) {
    return images.map((img) {
      if (img.isEmpty) return "";
      if (img.startsWith('http')) return img;
      return '$baseUrl$img';
    }).toList();
  }



  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'title': title,
      'description': description,
      'address': address,
      // 'image': image,
      'image': images,
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
    List<String>? images,
    String? address,
  }) {
    return OfferModel(
      id: id,
      name: name ?? this.name,
      title: title ?? this.title,
      // address: address ?? this.address,
      // image: image,
      images: images ?? this.images,
      description: description,
      category: category ?? this.category,
      isFavourite: isFavourite ?? this.isFavourite,
      discount: discount ?? this.discount,
      address: address ?? this.address,
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



