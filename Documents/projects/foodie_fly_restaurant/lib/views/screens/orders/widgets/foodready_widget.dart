import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/order/order_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/order_details/order_details.dart';
import 'package:intl/intl.dart';

class FoodReadyWidget extends StatelessWidget {
  const FoodReadyWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15,top: 5),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          final orders = state.orders
              .where((element) =>
                  element.orderStatus.toLowerCase() == 'food ready')
              .toList();
          return orders.isEmpty
              ? const Center(child: Text('food ready page  is Empty'))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScreenOrderDetails(
                              order: orders[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: width,
                        // height: height * .25,
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: Column(
                          children: [
                            kHight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Order Id: '),
                                Text(
                                  orders[index].orderId.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                            kHight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Order on: '),
                                Text(
                                  DateFormat("d MMM yyyy").format(
                                    DateTime.parse(orders[index].deliveryDate),
                                  ),
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                            kHight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Amount: '),
                                Text(
                                  '₹ ${state.orders[index].totalPrice - state.orders[index].deliveryCharge}',
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                            kHight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Item count: '),
                                Text(
                                  orders[index].itemCount.toString(),
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                            kHight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delivery Status: '),
                                Text(
                                  orders[index].orderStatus,
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                            kHight10,
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
