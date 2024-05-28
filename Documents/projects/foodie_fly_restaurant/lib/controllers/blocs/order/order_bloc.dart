// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/orders/api_calling.dart';
import 'package:foodie_fly_restaurant/models/order.dart';
import 'package:foodie_fly_restaurant/models/order_items.dart';
import 'package:foodie_fly_restaurant/models/order_status.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/snackbar_function.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<GetAllOrdersEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await OrderApiService().getAllOrders();
        emit(OrderLoaded(orders: orders, orderItems: []));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });

    on<GetOrderByIdEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await OrderApiService().getAllOrders();
        final orderItems = await OrderApiService().getOrderById(event.orderId);
        emit(OrderLoaded(orders: orders, orderItems: orderItems));
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });

    on<UpdateStatusEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final value =
            await OrderApiService().updateStatus(event.orderId, event.status);
        if (value) {
          final orders = await OrderApiService().getAllOrders();
          final orderItems =
              await OrderApiService().getOrderById(event.orderId);
          showSnack(event.context, Colors.green, 'Order Status updated.');
          emit(OrderLoaded(orders: orders, orderItems: orderItems));
        } else {
          showSnack(event.context, Colors.red, 'Order Status not updated.');
          emit(OrderError(message: 'Order Status not updated.'));
        }
      } catch (e) {
        showSnack(event.context, Colors.red, 'An error occurred.');
        emit(OrderError(message: e.toString()));
      }
    });
  }
}
