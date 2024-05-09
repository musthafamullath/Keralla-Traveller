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
      // print(dish.categoryId);
      // print(dish.description);
      // print(dish.dishId);
      // print(dish.image);
      // print(dish.isAvailable);
      // print(dish.isVeg);
      // print(dish.name);
      // print(dish.price);
      // print(dish.quantity);
      // print(dish.sellerId);
      final body = FormData.fromMap(dish.toJson(dish));
      // print('👀${body.files}');
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
      // print('❤️${response}');
      // print('😂${response}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log("DioException: ${e.message} is the exception");
      return false;
    } catch (e) {
      // print("Error: $e");
      log("🎉${e.toString()}");
      return false;
    }
  }

//--------------------FETCH DISHES ---------------------------------//
  Future<List<DishModel>> fetchDishesbyCategory(int categoryId) async {
    final bearer = await getToken();
    log('CATEGORYID${ApiEndPoints.baseUrl}${ApiEndPoints.getDishesByCategory}$categoryId 🤝');

    // print("👇");
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
        // print(response);
        // print("-------👀----");
        // print(response.statusCode);

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
  Future<bool> deleteDish(int dishId) async {
    final token = await getToken();

    final response = await dio.delete(
      '${ApiEndPoints.deleteOrUpdateDish}$dishId',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    // print("🍿${response.statusCode}");
    // print(response);
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print(e.toString());
      return false;
    }
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
      // print(response.data.toString());
      if (response.statusCode == 200) {
        // print('status 200');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("🎉${e.toString()}");
      // print('not edited');
      // print(e.toString());
      return false;
    }
  }
}
