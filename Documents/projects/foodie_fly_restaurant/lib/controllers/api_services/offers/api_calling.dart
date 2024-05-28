
// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:foodie_fly_restaurant/models/offer.dart';

class OfferApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //--------------------add offer-----------------------------------//

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
      if (response.statusCode == 200) {
        final body = response.data as Map;
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
      print(e.toString());
      return [];
    }
  }
  //---------------------------add offer-----------------------------//
    Future<bool> addOffer(OfferRequest offer) async {
    final bearer = await getToken();
    try {
      final body = FormData.fromMap(offer.toJson(offer));
      final response = await dio.post(ApiEndPoints.addOffers,
          data: body,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $bearer'
          }));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //---------------------------updateOffer---------------------------//
  Future<bool> updateOffer(Offer offer) async {
    try {
      final token = await getToken();
      print("👇$token");
      final response = await dio.put(
        "${ApiEndPoints.getAllOffers}${offer.offerId}",
        data: offer.toJson(offer),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      print("🎉$response");
      print("🎉${response.statusCode}");
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print("🙌${e.toString()}");
      return false;
    }
  }
}
