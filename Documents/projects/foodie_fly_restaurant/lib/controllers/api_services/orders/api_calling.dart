import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:foodie_fly_restaurant/models/order.dart';
import 'package:foodie_fly_restaurant/models/order_items.dart';
import 'package:foodie_fly_restaurant/models/order_status.dart';

class OrderApiService {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  //-------------Get All Orders---------------------------------//
  Future<List<Order>> getAllOrders() async {
    final token = await getToken();
    log("🤝$token");
    try {
      final response = await dio.get(ApiEndPoints.getAllOrders,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }));
      log("🎉$response");
      log("☝️${response.statusCode}");
      log("🍿${response.data}");
      if (response.statusCode == 200) {
        final body = response.data as Map;
        final result = body['orders'] as List;
        List<Order> orders = [];
        for (int i = 0; i < result.length; i++) {
          final order = Order.fromJson(result[i]);
          orders.add(order);
        }
        log("❤️$orders");
        return orders;
      }
      return [];
    } catch (e) {
      log('👇${e.toString()}');
      return [];
    }
  }

  //---------------------Get Order By Id-------------------------//
  Future<List<OrderItem>> getOrderById(int orderId) async {
    final token = await getToken();
    log("🤝$token");
    try {
      final response = await dio.get(
        '${ApiEndPoints.getOrderById}$orderId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      log("🎉$response");
      log("☝️${response.statusCode}");
      log("🍿${response.data}");
      if (response.statusCode == 200) {
        final body = response.data as Map;
        final result = body['orderItems'] as List;
        List<OrderItem> orderItems = [];
        for (int i = 0; i < result.length; i++) {
          final orderItem = OrderItem.fromJson(result[i]);
          orderItems.add(orderItem);
        }
        log("❤️$orderItems");
        return orderItems;
      }
      return [];
    } catch (e) {
      log('😊${e.toString()}');
      return [];
    }
  }

  //----------------------Update Status--------------------------------//
  Future<bool> updateStatus(int orderId, OrderStatus status) async {
    try {
      final token = await getToken();
      log("🤝$token");
      final data = status.toJson(status);
      log("❤️$data");
      final response = await dio.patch(
        '${ApiEndPoints.getOrderById}$orderId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
        data: data,
      );
      log("🎉$response");
      log("☝️${response.statusCode}");
      log("🍿${response.data}");
      if (response.statusCode == 200) {
        log('😍Response Data: ${response.data}');
        return true;
      } else if (response.statusCode == 200) {
        log('✌️Internal Server Error: ${response.data}');
        return false;
      } else {
        log('🙌Error Response Data: ${response.data}');
        return false;
      }
    } catch (e) {
      log('👀Error occurred: $e');
      return false;
    }
  }
}
