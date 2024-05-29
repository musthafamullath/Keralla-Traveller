import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/order/order_bloc.dart';
import 'package:foodie_fly/model/order.dart';
import 'package:foodie_fly/view/screen/orders/widgets/all_orders.dart';
import 'package:foodie_fly/view/screen/orders/widgets/tabbar_custom_widget.dart';
import 'package:shimmer/shimmer.dart';

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
              if (state.loading) {
                return const LoadingWidget();
              } else {
                return AllOrders(
                  order: state.orders,
                );
              }
            },
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state.loading) {
                return const LoadingWidget();
              } else {
                List<Order> orders = state.orders
                    .where((e) => e.orderStatus.toLowerCase() == 'delivered')
                    .toList();
                return AllOrders(
                  order: orders,
                );
              }
            },
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state.loading) {
                return const LoadingWidget();
              } else {
                List<Order> orders = state.orders
                    .where((e) =>
                        e.orderStatus.toLowerCase() == 'ordered' ||
                        e.orderStatus.toLowerCase() == 'pending' ||
                        e.orderStatus.toLowerCase() == 'food ready')
                    .toList();
                return AllOrders(
                  order: orders,
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Shimmer.fromColors(
        baseColor: Colors.green.shade100,
        highlightColor: Colors.green.shade50,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), 
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 16,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

