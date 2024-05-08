
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/category.dart';

import 'package:http/http.dart' as http;
class CategoriesApiServices {
  static const String baseUrl = ApiEndPoints.baseUrl;
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  Future<List<Category>> fetchAllCategories() async {
    try {
      const url = '$baseUrl/categories';
      String token = await getToken();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map;
        final result = body['categories'] as List;
        List<Category> categories = [];
        for (int i = 0; i < result.length; i++) {
          final category = Category.fromJson(result[i] as Map<String, dynamic>);
          categories.add(category);
        }
        return categories;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}