part of 'order_bloc.dart';

class OrderState {
  final List<Order> orders;
  final List<OrderItem> orderItems;
  final bool loading;

  OrderState({required this.orders, required this.orderItems, this.loading = false});
}

final class OrderInitial extends OrderState {
  OrderInitial() : super(orders: [], orderItems: [], loading: true);
}
