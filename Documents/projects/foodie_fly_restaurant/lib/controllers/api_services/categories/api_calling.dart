
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';

class CategoriesApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  Future<List<Category>> getAndFetchAllCategories() async {
    
    try {
    
      String token = await getToken();
      final response = await dio.get(
        ApiEndPoints.categories,
        options: Options(
           headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        ),
       
      );
      if(response.statusCode == 200){
        final body = response.data as Map;
        final result = body['categories'] as List;
        List<Category> categories = [];
        for(int i =0; i < result.length; i++){
          final category = Category.fromJson(result[i] as Map<String,dynamic>);
          categories.add(category);
        }
        return categories;
      }else{
        return [];
      }
    } catch (e) {
      log("🎉${e.toString()}");
      return [];
    }
  }
}
