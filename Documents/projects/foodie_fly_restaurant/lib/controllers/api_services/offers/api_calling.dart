
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:foodie_fly_restaurant/models/offer.dart';

class OfferApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //--------------------add offer-----------------------------------//
  Future<String> addOffer(OfferRequest offerRequest) async {
    final bearer = await getToken();
    // print("👀${offerRequest.categoryId}");
    // print("👀${offerRequest.image.filename}");
    // print("👀${offerRequest.offerPercentage}");
    // print("👀${offerRequest.offerTitle}");
    // print("👀${offerRequest.status}");
    // print(DateTime.now());
    try {
      // final body = jsonEncode(offerRequest.toJson(offerRequest));
      final body = FormData.fromMap(offerRequest.toJson(offerRequest));
      // print("👀${body}");
      final response = await dio.post(ApiEndPoints.addOffers,
          data: body,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
            //  'accept': 'application/json',
            'Authorization': 'Bearer $bearer'
          }));
      // print("😂${response.statusCode}");
      // print("❤️${response.data}");
      // print("👇${response}");
      final responseBody = response.data;
      // print("🤝${responseBody}");
      if (response.statusCode == 200) {
        return "offer created successfully";
      } else if (response.statusCode == 400) {
        if (responseBody['message'] == "invalid inputs") {
          return "invalid inputs";
        } else if (responseBody['message'] == "failed to get image from form") {
          return "failed to get image from form";
        } else {
          return '';
        }
      } else if (response.statusCode == 500) {
        if (responseBody['message'] == "failed to parse body") {
          return "failed to parse body";
        } else if (responseBody['message'] ==
            "failed to open file path in server") {
          return "failed to open file path in server";
        } else if (responseBody['message'] ==
            "failed to upload file to cloud") {
          return "failed to upload file to cloud";
        } else if (responseBody['message'] == "failed to delete temp image") {
          return "failed to delete temp image";
        } else if (responseBody['message'] ==
            "error occured while creating offer") {
          return "error occured while creating offer";
        }
        return '';
      }
      return '';
    } on DioException catch (e) {
      // print("_________________😍----------");
     log("🎉${e.toString()}");
      return '';
    } catch (e) {
      // print("_________________🎉----------");
      log("🎉${e.toString()}");
      return '';
    }
  }

  //-------------------------------get all offers-----------------------//
  Future<List<Offer>> getAllOffers() async {
    final token = await getToken();

    try {
      final response = await dio.get(
        ApiEndPoints.getAllOffers,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      // print(response.data);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final body = response.data as Map;
        // print("👇🎉${body}");
        final result = body['offerList'] as List;
        List<Offer> offers = [];
        for (int i = 0; i < result.length; i++) {
          final offer = Offer.fromJson(result[i]);
          offers.add(offer);
        }
        return offers;
      } else {
        return [];
      }
    } catch (e) {
      log("🎉${e.toString()}");
      // print(e.toString());
      return [];
    }
  }

  //---------------------------updateOffer---------------------------//
  Future<bool> updateOffer(Offer offer) async {
    try {
      final token = await getToken();
      // print("👇$token");
      final response = await dio.put(
        "${ApiEndPoints.getAllOffers}${offer.offerId}",
        data: offer.toJson(offer),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      // print("🎉$response");
      // print("🎉${response.statusCode}");
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      log("🙌${e.toString()}");
      return false;
    }
  }
}
