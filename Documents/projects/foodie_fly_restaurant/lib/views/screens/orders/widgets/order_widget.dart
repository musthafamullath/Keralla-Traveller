import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/order/order_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/order_details/order_details.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
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
          return state.orders.isEmpty
              ? const Center(child: Text('All Order page is Empty'))
              : ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScreenOrderDetails(
                              order: state.orders[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: yellow),
                        ),
                        child: Column(
                          children: [
                            kHight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Order Id: '),
                                Text(
                                  state.orders[index].orderId.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: boldGrey,
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
                                    DateTime.parse(
                                        state.orders[index].deliveryDate),
                                  ),
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                            kHight10,
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
                                  state.orders[index].itemCount.toString(),
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
                                  state.orders[index].orderStatus,
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
