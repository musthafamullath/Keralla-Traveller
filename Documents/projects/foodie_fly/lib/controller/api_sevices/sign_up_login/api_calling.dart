// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {


  //---------------------------------SignUp-------------------------------------

  Future<bool> signUp(User user) async {
    const url = '${ApiEndPoints.baseUrl}${ApiEndPoints.signup}';
    final data = {
      "firstName": user.fName,
      "lastName": user.lName,
      "email": user.email,
      "password": user.password,
      "confirmPassword": user.rePassword,
      "phone": user.phone
    };
    try {
      final response = await http.post(Uri.parse(url), body: data);
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        final body = jsonDecode(response.body) as Map;
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', body['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

//------------------------------OTP Verification--------------------------------

// Replace with your API base URL

  Future<bool> otpVerification(String otp) async {
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
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  //-----------------------------------Login------------------------------------

  Future<bool> login(String email, String password) async {
    try {
      const url = '${ApiEndPoints.baseUrl}${ApiEndPoints.login}';
      final data = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        final body = jsonDecode(response.body) as Map;
        await saveToken(body['token']);
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}