// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/user.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiAuthentication {
  //----------------------------------------------------------sign up----------------------------------------------------------//
  static Future<String> signup(User user) async {
    const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.signup}";
    final data = {
      "firstName": user.fName,
      "lastName": user.lName,
      "email": user.email,
      "password": user.password,
      "confirmPassword": user.rePassword,
      "phone": user.phone
    };
    print(data);
    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      debugPrint('Response ${response.statusCode}');
      print(response);

      final responseBody = jsonDecode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        preferences.setBool('ON_BORD', true);
        final body = jsonDecode(response.body) as Map;
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', body['token']);
        return "Success";
      } else if (response.statusCode == 400) {
        if (responseBody['message'] == "failed. invalid fields") {
          return "failed. invalid fields";
        } else if (responseBody['message'] == "failed to signup user") {
          return "failed to signup user";
        }
        return '';
      } else if (response.statusCode == 500) {
        return "failed to parse body";
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  //----------------------------------------------------------OTP Verification-----------------------------------------------//
  Future<String> otpVerification(String otp) async {
    try {
      final String bearer = await getToken();
      const String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.verifyOtp}';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $bearer',
        },
        body: '{"otp": "$otp"}',
      );
      if(response.statusCode == 200){
        return "successfully verified";
      }else if(response.statusCode == 400){
        return "failed. invalid fields";
      }else if(response.statusCode == 401){
        return "Unotherized accesss";
      }else if(response.statusCode == 500){
        return "failed to parse bod";
      }
      return '';
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  //----------------------------------------------------------login----------------------------------------------------------//

  static Future<String> login(String email, String password) async {
    try {
      const url = "${ApiEndPoints.baseUrl}${ApiEndPoints.login}";
      final data = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("LOGIN", true);
        preferences.setBool('ON_BORD', true);
        final body = jsonDecode(response.body) as Map;
        await saveToken(body['token']);
        return "success";
      } else if (response.statusCode == 400) {
        if (responseBody['message'] == "failed. invalid fields") {
          return "failed. invalid fields";
        } else if (responseBody['message'] == "failed to Login") {
          return "failed to login";
        }
        return '';
      } else if (response.statusCode == 500) {
        return "failed to parse body";
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }
}
