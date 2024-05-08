// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/cart_item.dart';

class CartApiService{
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //-------------------------------Add To Cart--------------------------//
  Future<bool> addToCart(int dishId)async{
    final token = await getToken();
    print('Dish id: $dishId');
    try{
      final response = await dio.post(
        '${ApiEndPoints.addToCart}$dishId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }
        )
      );
      // print('xdfdfghhhhhhhhh${response.data}');
      if(response.statusCode == 500) {
        print('Failure: ${response.data.toString()}');
      }
      if(response.statusCode == 200){
        return true;
      }else {
        return false;
      }
      
    }
    catch(e){
      log("👇😍${e.toString()}");
      return false;
    }
  }
  //-----------------Decrease Form Cart--------------------------//
    Future<bool> decreaseFromCart(int dishId) async {
    final token = await getToken();
    try {
      final response = await dio.patch(
        '${ApiEndPoints.decreaseformcart}$dishId${ApiEndPoints.decreaseformdecrement}',
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
      log("👇${e.toString()}");
      return false;
    }
  }
 //--------------------------Delete item form cart----------------------//
  Future<bool> deleteItemFromCart(int dishId) async {
    final token = await getToken();
    try {
      final response = await dio.delete(
        '${ApiEndPoints.decreaseformcart}$dishId${ApiEndPoints.deleteItemFromCart}',
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
      log("👇${e.toString()}");
      return false;
    }
  }
  //---------------------Get All Cart Item-----------------------------//
    Future<List<CartItem>> getAllCartItems() async {
    try {
      final token = await getToken();
      final response = await dio.get(
        ApiEndPoints.getAllCartItems,
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
        final data = body['cart'] as Map;
        final result = data['dishes'] as List;
        List<CartItem> cartItems = [];
        for (int i = 0; i < result.length; i++) {
          final cartItem = CartItem.fromJson(result[i]);
          cartItems.add(cartItem);
        }
        return cartItems;
      } else {
        return [];
      }
    } catch (e) {
      log("👇🍿${e.toString()}");
      return [];
    }
  }

}