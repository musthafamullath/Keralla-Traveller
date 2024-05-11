import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/models/restaurant.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiSellerAuthentication {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //----------------------------------------------------------sign up----------------------------------------------------------//
  Future<bool> register(
      RestaurantRegisteration restaurantRegisteration) async {
    final data = {
      "email": restaurantRegisteration.email,
      "password": restaurantRegisteration.password,
      "confirmPassword": restaurantRegisteration.password,
      "name": restaurantRegisteration.name,
      "description": restaurantRegisteration.description,
      "pinCode": restaurantRegisteration.pinCode,
    };
    try {
      final response = await dio.post(
        ApiEndPoints.sellerRegister,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json',
          },
        ),
        data: jsonEncode(data),
      );
      debugPrint('Response ${response.statusCode}');
      final responseBody = response.data ;
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        saveToken(responseBody['token']);
        return true;
      } else {
        return false;
      }
   } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //----------------------------------------------------------login----------------------------------------------------------//

   Future<bool> login(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };
      final response = await dio.post(
        ApiEndPoints.sellerLogin,
        data: data,
      );
      final responseBody = response.data;
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("LOGIN", true);
        saveToken(responseBody['token']);
        return true;
      }
      return false;
    } catch (e) {
      log("👇${e.toString()}");
      return false;
    }
  }
}
