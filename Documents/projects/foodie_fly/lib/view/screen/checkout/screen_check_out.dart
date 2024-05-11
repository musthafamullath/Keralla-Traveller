// ignore_for_file: avoid_print

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/cart/cart_bloc.dart';
import 'package:foodie_fly/controller/blocs/payment/payment_bloc.dart';
import 'package:foodie_fly/model/checkout.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/item_row.dart';

// ignore: must_be_immutable
class ScreenCheckout extends StatelessWidget {
  ScreenCheckout(
      {super.key, required this.couponCode, required this.addressId});
  final String couponCode;
  final int addressId;

  int total = 0;

  List<String> values = ['COD', 'ONLINE'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: 'Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SectionHead(heading: 'Payment Details'),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is! CartInitial) {
                  state is GetAllCartItemsState
                      ? total = state.total - state.discount
                      : 0;
                  return Container(
                    width: width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.grey.shade200, width: 2),
                        color: Colors.grey.shade50),
                    child: Column(
                      children: [
                        ItemRow(
                            keyString: 'Item Total',
                            value: state is GetAllCartItemsState
                                ? '₹ ${state.total}'
                                : '₹ 0'),
                        divider3,
                        const ItemRow(
                            keyString: 'Delivery Charge', value: 'Free'),
                        divider3,
                        ItemRow(
                            keyString: 'Discount',
                            value: state is GetAllCartItemsState
                                ? '₹ ${state.discount}'
                                : '₹ 0'),
                        divider3,
                        ItemRow(
                          keyString: 'Total Amount',
                          value: state is GetAllCartItemsState
                              ? '₹ ${state.total - state.discount}'
                              : '₹ 200',
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No data '));
                }
              },
            ),
            kHight10,
            const Text(
              'Select your preferred payment method to complete the transaction seamlessly.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            kHight10,
            Column(
              children: List.generate(2, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(15)),
                    child: DottedBorder(
                      radius: const Radius.circular(20),
                      borderType: BorderType.RRect,
                      color: Colors.grey.shade200,
                      strokeWidth: 2,
                      dashPattern: const [5, 5],
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(
                          index == 0 ? 'Cash On Delivery' : 'Online Payment',
                          style: boldGrey,
                        ),
                        trailing: BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (context, state) {
                            return Radio(
                              value: values[index],
                              groupValue: state.method,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                context
                                    .read<PaymentBloc>()
                                    .add(PaymentMethodEvent(method: value!));
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            kHight20,
            BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                return ButtonWidget(
                  width: width,
                  text: state.method == 'COD' ? 'Checkout' : 'Proceed to pay',
                  onPressed: () async {
                    print('👀${state.method}');
                    if (state.method == 'COD') {
                      final checkOut = CheckOut(
                        addressId: addressId.toString(),
                        couponCode: couponCode,
                        paymentMethod: state.method,
                      );
                      context.read<CartBloc>().add(
                          CheckoutEvent(checkOut: checkOut, context: context));
                    } else if (state.method == 'ONLINE') {
                      final checkOut = CheckOut(
                        addressId: addressId.toString(),
                        couponCode: couponCode,
                        paymentMethod: state.method,
                      );
                      context.read<CartBloc>().add(
                          CheckoutEvent(checkOut: checkOut, context: context));
                    }
                  },
                  height: width * 3 / 10,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
