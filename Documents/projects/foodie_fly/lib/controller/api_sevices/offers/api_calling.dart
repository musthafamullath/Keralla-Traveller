// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/model/offer.dart';

class OfferApiServices{
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  
  //--------------------------Get All Offers ----------------------//
  Future<List<Offer>> getAllOffer()async{
    print("👇$dio");
    try{
      final response = await dio.get(
        ApiEndPoints.getAllOffers
      );
      print("🎉$response");
      if(response.statusCode == 200){
        final body = response.data as Map;
        print("🙌$body");
        final result = body["offerList"] as List;
        print('😍$result');
        List<Offer> offers = [];
        for(int i = 0; i < result.length; i++){
          final offer = Offer.fromJson(result[i]);
          print("👀$offer");
          offers.add(offer);
        }
        print('🤝$offers');
        return offers;
      }
      return [];
    }
    catch(e){
      log("🙌${e.toString()}");
      return [];
    }
  }
}