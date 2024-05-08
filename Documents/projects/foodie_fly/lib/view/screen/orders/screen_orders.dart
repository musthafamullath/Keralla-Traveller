import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/order/order_bloc.dart';
import 'package:foodie_fly/model/order.dart';
import 'package:foodie_fly/view/screen/orders/widgets/all_orders.dart';
import 'package:foodie_fly/view/screen/orders/widgets/tabbar_custom_widget.dart';

class ScreenOrders extends StatelessWidget {
  const ScreenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderBloc>().add(GetAllOrdersEvent());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: TabBarWidgetCustom(text: "Orders")
        ),
        body: TabBarView(children: [
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return AllOrders(
                order: state.orders,
              );
            },
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              List<Order> orders = state.orders
                  .where((e) => e.orderStatus.toLowerCase() == 'delivered')
                  .toList();
              return AllOrders(
                order: orders,
              );
            },
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              List<Order> orders = state.orders
                  .where((e) =>
                      e.orderStatus.toLowerCase() == 'ordered' ||
                      e.orderStatus.toLowerCase() == 'pending' ||
                      e.orderStatus.toLowerCase() == 'food ready')
                  .toList();
              return AllOrders(
                order: orders,
              );
            },
          ),
        ]),
      ),
    );
  }
}
