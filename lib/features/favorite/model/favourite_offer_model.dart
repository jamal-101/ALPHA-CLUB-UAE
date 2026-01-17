
import 'package:alpha_club/features/offer_flow/model/offer_model.dart';

class FavouriteOfferItem {
  final String id;
  final String user;
  final OfferModel exclusiveOffer;
  final String createdAt;
  final String updatedAt;

  FavouriteOfferItem({
    required this.id,
    required this.user,
    required this.exclusiveOffer,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavouriteOfferItem.fromJson(Map<String, dynamic> json) {
    return FavouriteOfferItem(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      exclusiveOffer: OfferModel.fromJson(json['exclusiveOffer'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class FavouriteOfferResponse {
  final bool success;
  final String message;
  final List<FavouriteOfferItem> data;

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
              ?.map((item) => FavouriteOfferItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}


