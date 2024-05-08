import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/checkout.dart';
import 'package:foodie_fly/model/checkout_response.dart';
import 'package:foodie_fly/model/verify_payment.dart';

class CheckOutApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //----------------CheckOut-------------------------------//
  Future<CheckoutResponse?> checkOut(CheckOut checkOut) async {
    final token = await getToken();
    final data = checkOut.toJson(checkOut);
    try {
      final response = await dio.post(
        ApiEndPoints.checkOut,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        final body = response.data as Map;
        CheckoutResponse checkoutResponse;
        if (body.containsKey('result')) {
          final result = body['result'] as Map<String, dynamic>;
          checkoutResponse = CheckoutResponse.fromJson(result);
          return checkoutResponse;
        }
      } else {
        return null;
      }
    } catch (e) {
      log('👇${e.toString()}');
      return null;
    }
    return null;
  }

  //---------------------Verify Payment---------------------------//
  Future<bool> verifyPayment(VerifyPayment verifyPayment) async {
    final token = await getToken();
    final data = verifyPayment.toJson(verifyPayment);
    try {
      final response = await dio.post(
        ApiEndPoints.verifyPayment,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: data,
      );
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      log('👇${e.toString()}');
      return false;
    }
  }
}
