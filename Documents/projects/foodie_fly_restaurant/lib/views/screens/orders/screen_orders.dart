import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/widgets/cooking_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/widgets/delivered_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/widgets/foodready_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/widgets/order_widget.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/widgets/tabbar_custom_widget.dart';

class ScreenOrders extends StatelessWidget {
  const ScreenOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: TabBarWidgetCustom(text: "Orders"),
        ),
        body: TabBarView(
          children: [
            OrderWidget(width: width),
            CookingWidget(width: width),
            FoodReadyWidget(width: width),
            DeliveredWidget(width: width)
          ],
        ),
      ),
    );
  }
}
