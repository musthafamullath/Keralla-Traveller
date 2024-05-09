import 'package:dio/dio.dart';

class Offer {
  final int offerId;
  final String offerTitle;
  final int sellerId;
  final int categoryId;
  final String imageUrl;
  final int offerPercentage;
  final String startDate;
  final String endDate;
  final String status;

  Offer({
    required this.offerId,
    required this.offerTitle,
    required this.sellerId,
    required this.categoryId,
    required this.imageUrl,
    required this.offerPercentage,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      offerId: json['offerId'],
      offerTitle: json['offerTitle'],
      sellerId: json['sellerId'],
      categoryId: json['categoryId'],
      imageUrl: json['imageUrl'],
      offerPercentage: json['offerPercentage'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson(Offer offer) {
    final Map<String, dynamic> data = {
      'offerId': offer.offerId,
      'offerTitle': offer.offerTitle,
      'sellerId': offer.sellerId,
      'categoryId': offer.categoryId,
      'imageUrl' : offer.imageUrl,
      'offerPercentage': offer.offerPercentage,
      'startDate': offer.startDate,
      'endDate': offer.endDate,
      'status': offer.status,
    };

    return data;
  }
}


class OfferRequest {
  
  final MultipartFile image;
  final int categoryId;
  final String offerTitle;
  // ignore: prefer_typing_uninitialized_variables
  final  offerPercentage;
  final String status;

  OfferRequest({
    required this.image,
    required this.categoryId,
    required this.offerTitle,
    required this.offerPercentage,
    required this.status,

  });
  Map<String, dynamic> toJson(OfferRequest offerRequest) {
    final data = {
      'image': offerRequest.image,
      'categoryId': offerRequest.categoryId,
      'offerPercentage': offerRequest.offerPercentage,
      'offerTitle': offerRequest.offerTitle,
      'status': offerRequest.status,
    };
    return data;
  }
}
