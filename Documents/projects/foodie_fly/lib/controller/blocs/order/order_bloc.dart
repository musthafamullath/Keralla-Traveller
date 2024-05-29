import 'package:bloc/bloc.dart';
import 'package:foodie_fly/controller/api_sevices/orders/api_calling.dart';
import 'package:foodie_fly/model/order.dart';
import 'package:foodie_fly/model/order_items.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<GetAllOrdersEvent>((event, emit) async {
      emit(OrderState(orders: [], orderItems: [], loading: true));
      final orders = await OrdersApiServices().getAllOrders();
      emit(OrderState(orders: orders, orderItems: [], loading: false));
    });

    on<GetOrderByIdEvent>((event, emit) async {
      emit(OrderState(orders: state.orders, orderItems: [], loading: true));
      final orderItems = await OrdersApiServices().getOrderById(event.orderId);
      emit(OrderState(orders: state.orders, orderItems: orderItems, loading: false));
    });
  }
}
