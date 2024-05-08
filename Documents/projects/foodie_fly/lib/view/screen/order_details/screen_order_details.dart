import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/order/order_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/model/address.dart';
import 'package:foodie_fly/model/order.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/screen/order_details/widgets/order_details_container.dart';
import 'package:foodie_fly/view/screen/order_details/widgets/order_tracker.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';

class ScreenOrderDetails extends StatelessWidget {
  const ScreenOrderDetails({super.key, required this.order, required this.address});
  final Order order;
  final Address address;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<OrderBloc>().add(GetOrderByIdEvent(orderId: order.orderId));
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarWidget(title: order.orderId.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Text('Hey ${state.profile?.firstName}',
                      style: bigBoldBlack);
                },
              ),
              kHight10,
              const Text(
                'Thank you for your order! We will keep you updated on its arrival.',
                style: semiBoldGrey,
              ),
              kHight10,
              OrderDetails(width: width, order: order, address: address),
              kHight20,
              Container(
                width: width,
                // height: height * .25,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHead(heading: 'Order Items'),
                        divider1,
                        BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            return Column(
                              children: List.generate(state.orderItems.length,
                                  (index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${state.orderItems[index].name}:  '),
                                    SizedBox(
                                      width: width * .4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'x ${state.orderItems[index].quantity}',
                                            style: semiBoldBlack,
                                          ),
                                          Text(
                                            '${state.orderItems[index].price * state.orderItems[index].quantity}',
                                            style: semiBoldBlack,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              kHight20,
              const SectionHead(heading: 'Order Status'),
              kHight10,
              OrderTracker(order: order)
            ],
          ),
        ),
      ),
    );
  }
}
