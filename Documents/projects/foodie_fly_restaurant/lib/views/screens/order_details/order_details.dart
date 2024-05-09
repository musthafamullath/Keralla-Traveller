import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/order/order_bloc.dart';
import 'package:foodie_fly_restaurant/models/order.dart';
import 'package:foodie_fly_restaurant/models/order_status.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/section_head.dart';
import 'package:intl/intl.dart';

class ScreenOrderDetails extends StatelessWidget {
  ScreenOrderDetails({super.key, required this.order});
  final Order order;
  final List<String> status = ['COOKING', 'FOOD READY', 'DELIVERED'];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    context.read<OrderBloc>().add(GetOrderByIdEvent(orderId: order.orderId));
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: 'Order details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    // height: height * .25,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.yellow, width: 1),
                    ),
                    child: Column(
                      children: [
                        kHight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Order Id: ', style: semiBoldBlack),
                            Text(
                              order.orderId.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: semiBoldGrey,
                            ),
                          ],
                        ),
                        kHight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Order on: ', style: semiBoldBlack),
                            Text(
                              DateFormat("  d MMMM yyy")
                                  .format(DateTime.parse(order.orderDate)),
                              style: semiBoldGrey,
                            ),
                          ],
                        ),
                        kHight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Item count: ', style: semiBoldBlack),
                            Text(
                              order.itemCount.toString(),
                              style: semiBoldGrey,
                            ),
                          ],
                        ),
                        kHight10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delivery Status: ',
                                style: semiBoldBlack),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(10)),
                              width: width * .4,
                              child: DropdownButtonFormField(
                                elevation: 5,
                                iconSize: 32,
                                borderRadius: BorderRadius.circular(5),
                                dropdownColor: Colors.grey.shade300,
                                iconEnabledColor: Colors.grey,
                                alignment: Alignment.center,
                                validator: (value) {
                                  if (value == null) return 'Choose category';
                                  return null;
                                },
                                decoration:  InputDecoration(
                                    label: Text(order.orderStatus),
                                    labelStyle: const TextStyle(
                                        color: grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    contentPadding: const  EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    border: InputBorder.none),
                                items: status.map((stat) {
                                  return DropdownMenuItem(
                                    value: stat,
                                    child: Text(
                                      stat,
                                      style: semiBoldGrey,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  final status =
                                      OrderStatus(orderStatus: value!);
                                  context.read<OrderBloc>().add(
                                      UpdateStatusEvent(
                                          orderId: order.orderId,
                                          status: status,
                                          context: context));
                                },
                              ),
                            )
                          ],
                        ),
                        kHight10,
                      ],
                    ),
                  ),
                  kHight10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.yellow, width: 1),
                      ),
                      child: Column(
                        children: [
                          kHight10,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SectionHead(
                                heading: 'Items',
                                values: '',
                              ),
                              kWidth50,
                              kWidth20,
                              kHight20,
                              Text('Count',style: semiBoldGrey,),
                              SectionHead(
                                heading: '',
                                values: 'Amount',
                              ),
                            ],
                          ),
                          kHight10,
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.orderItems.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.orderItems[index].name,
                                    style: semiBoldBlack,
                                  ),
                                  SizedBox(
                                    width: width * .25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'x ${state.orderItems[index].quantity}',
                                          style: boldGrey,
                                        ),
                                        Text(
                                          '₹ ${state.orderItems[index].salePrice * state.orderItems[index].quantity}',
                                          style: boldGrey,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          kHight10,
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1.5,
                          ),
                          kHight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount:',
                                style: semiBoldBlack,
                              ),
                              Text(
                                '₹ ${order.totalPrice - order.deliveryCharge}',
                                style: boldGrey,
                              ),
                            ],
                          ),
                          kHight10,
                        ],
                      ),
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
