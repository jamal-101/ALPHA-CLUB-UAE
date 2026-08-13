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
  final String businessDescription;
  final String address;

  final double? latitude;
  final double? longitude;

  OfferModel({
    required this.id,
    required this.name,
    required this.title,
    required this.images,
    required this.category,
    required this.isFavourite,
    required this.description,
    required this.businessDescription,
    required this.address,
    this.discount,
    this.latitude, // 🟢
    this.longitude,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {

    List<String> imageList = [];
    if (json['image'] is List) {
      imageList = List<String>.from(json['image'].map((x) => x.toString()));
    } else if (json['image'] != null && json['image'].toString().isNotEmpty) {
      imageList = [json['image'].toString()];
    }

    double? lat;
    double? lng;
    if (json['location'] != null && json['location']['coordinates'] is List) {
      final List<dynamic> coords = json['location']['coordinates'];
      if (coords.length >= 2) {
        lng = double.tryParse(coords[0].toString()); // GeoJSON এ প্রথম ভ্যালু Longitude
        lat = double.tryParse(coords[1].toString()); // GeoJSON এ দ্বিতীয় ভ্যালু Latitude
      }
    }

    return OfferModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      address: json['address']?.toString() ?? 'No address found',

      images: imageList,
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : Discount(enable: false, value: 0),
      description: json['description'] ?? '',
      businessDescription: json['businessDescription'] ?? '',
      category: OfferCategory.fromJson(json['category'] ?? {}),
      isFavourite: json['isFavourite'] ?? false,
      latitude: lat,
      longitude: lng,
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
      'location': {
        'type': 'Point',
        'coordinates': [longitude, latitude]
      }
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
    double? latitude, // 🟢
    double? longitude,
  }) {
    return OfferModel(
      id: id,
      name: name ?? this.name,
      title: title ?? this.title,
      // address: address ?? this.address,
      // image: image,
      images: images ?? this.images,
      description: description,
      businessDescription: businessDescription,
      category: category ?? this.category,
      isFavourite: isFavourite ?? this.isFavourite,
      discount: discount ?? this.discount,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude, // 🟢
      longitude: longitude ?? this.longitude,
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



