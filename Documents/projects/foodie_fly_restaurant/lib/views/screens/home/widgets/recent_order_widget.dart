
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/order/order_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/order_details/order_details.dart';
import 'package:intl/intl.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if(state is OrderLoading){
          return const SpinKitWave(
                color: yellow,
                size: 50.0,
              );
          
        }
        final recentOrders =  state.orders.take(2).toList();
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
              recentOrders.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10),
                  child: Card(
                    shadowColor: grey,
                    surfaceTintColor: grey,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5,
                              color:
                                  Colors.grey.shade300),
                          borderRadius:
                              BorderRadius.circular(
                                  10)),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  const EdgeInsets
                                      .symmetric(
                                      horizontal: 8),
                              title: Text(
                                'Order id: ${state.orders[index].orderId}',
                                style: regularGrey,
                              ),
                              subtitle: Text(
                                'Order Amount: ₹ ${state.orders[index].totalPrice - state.orders[index].deliveryCharge}\nDate: ${DateFormat('d MMMM yyyy').format(DateTime.parse(state.orders[index].orderDate))}',
                                style: regularGrey,
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: Colors
                                    .grey
                                    .withOpacity(0.3),
                                radius: 24,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(
                                            context)
                                        .push(
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                ScreenOrderDetails(
                                          order: state
                                                  .orders[
                                              index],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons
                                        .chevron_forward,
                                    size: 32,
                                    fill: BorderSide
                                        .strokeAlignCenter,
                                  ),
                                ),
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
