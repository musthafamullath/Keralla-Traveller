
// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/seller.dart';

class SellerApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //-----------------fetch All Sellers --------------------//
  Future<List<Seller>> fetchAllSellers() async {
    final String bearer = await getToken();

    print("😍${bearer}");
    try {
      final response = await dio.get(
        ApiEndPoints.userSeller,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearer',
        }),
      );
      print("❤️${response}");
      print("👇${response.statusCode}");
      print("🎉${response.data}");
      if (response.statusCode == 200) {
        final body = response.data as Map;
        final result = body["sellerList"] as List;
        print("✌️${result}");
        final sellers = <Seller>[];
        for (int i = 0; i < result.length; i++) {
          final seller = Seller.fromJson(result[i]);
          sellers.add(seller);
        }
        print('☝️$sellers');
        return sellers;
      } else {
        return [];
      }
    } catch (e) {
      log("🍿${e.toString()}");
      return [];
    }
  }

  //--------------------search Sellers----------------------------//
  Future<List<Seller>> searchSeller(String query) async {
    try {
      final response = await dio.get(
        ApiEndPoints.searchSeller + query,
      );
      print("❤️${response}");
      print("👇${response.statusCode}");
      print("🎉${response.data}");
      if (response.statusCode == 200) {
        final body = response.data as Map;
        final result = body['sellerList'] as List;
        print("✌️${result}");
        final sellers = <Seller>[];
        for (int i = 0; i < result.length; i++) {
          final seller = Seller.fromJson(result[i]);
          sellers.add(seller);
        }
        print('☝️$sellers');
        return sellers;
      } else {
        return [];
      }
    } catch (e) {
      log("🍿${e.toString()}");
      log(e.toString());
      return [];
    }
  }

  //--------------------------get Seller by Id--------------------//
  Future<Seller?> getSellerById(int sellerId) async {
    final String bearer = await getToken();
    print("😍${bearer}");
    try {
      final response = await dio.get(
        '${ApiEndPoints.getSellerById}+$sellerId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $bearer',
          },
        ),
      );
      print("❤️${response}");
      print("👇${response.statusCode}");
      print("🎉${response.data}");
      if(response.statusCode == 200){
        final body = response.data as Map;
        final result = body['seller'];
        print("✌️${result}");
        final seller = Seller.fromJson(result);
         print('☝️$seller');
        return seller;
      }else{
        return null;
      }
    } catch (e) {
      log("🤝👀${e.toString()}");
       return null;
    }
   
  }
}
