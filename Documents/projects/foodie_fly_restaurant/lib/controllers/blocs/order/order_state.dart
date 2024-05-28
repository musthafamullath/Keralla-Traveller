part of 'order_bloc.dart';

class OrderState {
  final List<Order> orders;
  final List<OrderItem> orderItems;
  OrderState({required this.orders, required this.orderItems});
}

final class OrderInitial extends OrderState {
  OrderInitial() : super(orders: [], orderItems: []);
}

class OrderLoading extends OrderState {
  OrderLoading() : super(orders: [], orderItems: []);
}

class OrderLoaded extends OrderState {
  OrderLoaded(
      {required super.orders, required super.orderItems});
}

class OrderError extends OrderState {
  final String message;

  OrderError({required this.message}) : super(orders: [], orderItems: []);
}
