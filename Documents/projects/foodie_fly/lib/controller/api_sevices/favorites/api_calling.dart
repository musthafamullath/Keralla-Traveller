import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/dish.dart';

class FavoriteApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //-----------------Add To Favorites------------------------------//
  Future<bool> addToFavorite(int dishId) async {
    final token = await getToken();
    final response = await dio.post('${ApiEndPoints.addToFavorites}$dishId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('👇${e.toString()}');
      return false;
    }
  }

  //------------------------------delete From Fovorites----------------//
  Future<bool> deleteFromFovorites(int dishId) async {
    final token = await getToken();
    final response = await dio.delete(
        '${ApiEndPoints.favourites}$dishId${ApiEndPoints.delete}',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(
        '👇${e.toString()}',
      );
      return false;
    }
  }
  //---------------Get All Favorites-------------------------------//
  Future<List<Dish>> getAllFavorites()async{
    final token = await getToken();

    try{
      final response = await dio.get(
      ApiEndPoints.getAllFavorites,
      options: Options(
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token', 
        }
      )
    );
    if(response.statusCode == 200){
      final body = response.data as Map;
      final result = body['result'] as List;
      List<Dish> dishes = [];
      for(int i = 0; i< result.length; i++){
        final dish = Dish.fromJson(result[i]);
        log(dish.name);
        dishes.add(dish);
      }
      return dishes;
    }else{
      return [];
    }
    }catch(e){
      log('👇${e.toString()}');
      return [];
    }
  }
}
