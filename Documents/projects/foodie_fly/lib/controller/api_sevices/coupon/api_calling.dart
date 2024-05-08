import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/coupon.dart';

class CouponApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //------------------Get All Coupons------------------------//
  Future<List<Coupon>> getAllCoupons() async {
    final token = await getToken();
    try {
      final response = await dio.get(
        ApiEndPoints.getAllCoupons,
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
        final result = body['coupons'] as List;
        List<Coupon> coupons = [];
        for (int i = 0; i < result.length; i++) {
          final coupon = Coupon.fromJson(result[i]);
          coupons.add(coupon);
        }
        return coupons;
      } else {
        return [];
      }
    } catch (e) {
      log('👇${e.toString()}');
      return [];
    }
  }

  //-------------------------Get available coupens--------------------//
  Future<List<Coupon>> getAvailableCoupons() async {
    final token = await getToken();
    try {
      final response = await dio.get(
        ApiEndPoints.getAvailableCoupons,
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
        final result = body['coupons'] as List;
        List<Coupon> coupons = [];
        for(int i = 0; i < result.length; i++){
          final coupon = Coupon.fromJson(result[i]);
          coupons.add(coupon);
        }
        return coupons;
      } else {
        return [];
      }
    } catch (e) {
      log('👇${e.toString()}');
      return [];
    }
  }
}
