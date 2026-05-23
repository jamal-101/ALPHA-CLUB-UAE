//
// import 'package:alpha_club/features/offer_flow/model/offer_model.dart';
//
// class FavouriteOfferItem {
//   final String id;
//   final String user;
//   final OfferModel exclusiveOffer;
//   final String createdAt;
//   final String updatedAt;
//
//
//   FavouriteOfferItem({
//     required this.id,
//     required this.user,
//     required this.exclusiveOffer,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory FavouriteOfferItem.fromJson(Map<String, dynamic> json) {
//     return FavouriteOfferItem(
//       id: json['_id'] ?? '',
//       user: json['user'] ?? '',
//       exclusiveOffer: OfferModel.fromJson(json['exclusiveOffer'] ?? {}),
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }
// }
//
// class FavouriteOfferResponse {
//   final bool success;
//   final String message;
//   final List<FavouriteOfferItem> data;
//
//   FavouriteOfferResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   factory FavouriteOfferResponse.fromJson(Map<String, dynamic> json) {
//     return FavouriteOfferResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((item) => FavouriteOfferItem.fromJson(item))
//               .toList() ??
//           [],
//     );
//   }
// }
//
//

import '../../offer_flow/model/offer_model.dart';

class FavouriteOfferResponse {
  final bool success;
  final String message;
  final List<FavoriteModel> data; // এখানে সরাসরি OfferModel ব্যবহার করুন

  FavouriteOfferResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FavouriteOfferResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteOfferResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => FavoriteModel.fromJson(item))
          .toList() ?? [],
    );
  }
}


class FavoriteModel {
  final String id;
  final String user;
  final ExclusiveOffer exclusiveOffer;
  final DateTime createdAt;
  final DateTime updatedAt;

  FavoriteModel({
    required this.id,
    required this.user,
    required this.exclusiveOffer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['_id']?.toString() ?? '',
      user: json['user']?.toString() ?? '',
      exclusiveOffer:
      ExclusiveOffer.fromJson(json['exclusiveOffer'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

/* ================= Exclusive Offer ================= */

class ExclusiveOffer {
  final String id;
  final String name;
  final String title;
  final String address;
  final Location location;
  final List<String> image;
  final String description;
  final Discount discount;
  final OfferCategory category;

  ExclusiveOffer({
    required this.id,
    required this.name,
    required this.title,
    required this.address,
    required this.location,
    required this.image,
    required this.description,
    required this.discount,
    required this.category,
  });

  factory ExclusiveOffer.fromJson(Map<String, dynamic> json) {
    return ExclusiveOffer(
      id: json['_id']?.toString() ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      image: List<String>.from(json['image'] ?? []),
      description: json['description'] ?? '',
      discount: Discount.fromJson(json['discount'] ?? {}),
      category: OfferCategory.fromJson(json['category'] ?? {}),
    );
  }
}

/* ================= Location ================= */

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [],
    );
  }

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get latitude =>
      coordinates.length > 1 ? coordinates[1] : 0.0;
}

/* ================= Discount ================= */

class Discount {
  final bool enable;
  final int value;

  Discount({
    required this.enable,
    required this.value,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      enable: json['enable'] ?? false,
      value: (json['value'] ?? 0).toInt(),
    );
  }
}

/* ================= Category ================= */

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
      name: json['name'] ?? '',
    );
  }
}
