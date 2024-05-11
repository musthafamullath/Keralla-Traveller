// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';

class DishApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));

//---------------------------ADD DISH ----------------------------//
  Future<bool> addDish(Dish dish) async {
    final bearer = await getToken();
    try {
      final body = FormData.fromMap(dish.toJson(dish));
      final response = await dio.post(
        ApiEndPoints.addDish,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'accept': 'application/json',
            'Authorization': 'Bearer $bearer'
          },
        ),
        data: body,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log("DioException: ${e.message} is the exception");
      return false;
    } catch (e) {
      log("🎉${e.toString()}");
      return false;
    }
  }

//--------------------FETCH DISHES ---------------------------------//
  Future<List<DishModel>> fetchDishesbyCategory(int categoryId) async {
    final bearer = await getToken();
    log('CATEGORYID${ApiEndPoints.baseUrl}${ApiEndPoints.getDishesByCategory}$categoryId 🤝');
    try {
      final response = await dio.get(
        '${ApiEndPoints.getDishesByCategory}$categoryId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $bearer',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final result = data['dishList'] as List;
        List<DishModel> dishes = [];
        for (int i = 0; i < result.length; i++) {
          final dish = DishModel.fromJson(result[i]);
          dishes.add(dish);
        }
        return dishes;
      } else {
        return [];
      }
    } on DioException catch (e) {
      log("🎉${e.toString()}");
      return [];
    } catch (e) {
      log("🎉${e.toString()}");
      return [];
    }
  }

//--------------------------DELETE DISH ------------------------------//
   Future<void> deleteDish(int dishId) async {
    final token = await getToken();
    final response = await dio.delete(
      '${ApiEndPoints.deleteOrUpdateDish}$dishId',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    print(response.statusCode);
  }

//--------------------------UPDATE DISH-------------------------------//
  Future<bool> updateDish(DishModel dishModel) async {
    try {
      final token = await getToken();
      final response = await dio.put(
        '${ApiEndPoints.deleteOrUpdateDish}${dishModel.dishId}',
        data: FormData.fromMap(dishModel.toJson(dishModel)),   
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("🎉${e.toString()}");
      return false;
    }
  }
}
