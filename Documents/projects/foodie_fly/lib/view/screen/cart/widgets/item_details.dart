 // ignore_for_file: unused_local_variable

 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/cart/cart_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/widgets/class_widgets/item_row.dart';

Container itemDetails(double width) {
   String couponCode = '';
    return Container(
                            width: width,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2,color: Colors.grey.shade300)
                            ),
                            child: Column(
                              children: [
                                BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    return ItemRow(
                                      keyString: 'Item Total : ',
                                      value: state is GetAllCartItemsState
                                          ? '₹ ${state.total}'
                                          : '₹ 0',
                                      width: 5,
                                      thickness: width * 1 / 200,
                                      color: grey,
                                    );
                                  },
                                ),
                                kHight10,
                                divider3,
                                ItemRow(
                                  keyString: 'Delivery fee :',
                                  value: 'free',
                                  width: 5,
                                  thickness: width * 1 / 200,
                                  color: grey,
                                ),
                                kHight10,
                                divider3,
                                BlocBuilder<CartBloc, CartState>(
                                  buildWhen: (previous, current) =>
                                      current is! CartInitial,
                                  builder: (context, state) {
                                    if (state is GetAllCartItemsState) {
                                      return ItemRow(
                                        width: 5,
                                        thickness: width * 1 / 200,
                                        color: grey,
                                        keyString: 'Discount :',
                                        value: '₹ ${state.discount}',
                                      );
                                    }
                                    return ItemRow(
                                      width: 5,
                                      thickness: width * 1 / 200,
                                      color: Colors.grey,
                                      keyString: 'Discount :',
                                      value: '₹ 0',
                                    );
                                  },
                                ),
                                
                                divider3,
                                kHight10,
                                BlocBuilder<CartBloc, CartState>(
                                  buildWhen: (previous, current) =>
                                      current is! CartInitial,
                                  builder: (context, state) {
                                    state is GetAllCartItemsState
                                        ? couponCode = state.couponCode
                                        : '';
                                    return ItemRow(
                                      width: 5,
                                      thickness: width * 1 / 200,
                                      color: grey,
                                      keyString: 'Total Amount : ',
                                      value: state is GetAllCartItemsState
                                          ? '₹ ${state.total - state.discount}'
                                          : state is GetAllCartItemsState
                                              ? '₹ ${state.total}'
                                              : '₹ 0',
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
  }
