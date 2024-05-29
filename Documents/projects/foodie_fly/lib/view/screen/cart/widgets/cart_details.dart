// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/cart/cart_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:input_quantity/input_quantity.dart';

BlocBuilder<CartBloc, CartState> cartDetatils(double height) {
    int sellerId = 0;
    return BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    return state is GetAllCartItemsState &&
                                            state.cartItems.isEmpty
                                        ? const Center(
                                            child: Text('Cart is empty.'),
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              sellerId = state
                                                      is GetAllCartItemsState
                                                  ? state.cartItems[index]
                                                      .sellerId
                                                  : 0;
                                              return SizedBox(
                                                height: height * .065,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state is GetAllCartItemsState
                                                              ? state
                                                                  .cartItems[
                                                                      index]
                                                                  .name
                                                              : 'Dish name',
                                                          style:
                                                              semiBoldBlack,
                                                          overflow:
                                                              TextOverflow
                                                                  .clip,
                                                        ),
                                                        state
                                                                is GetAllCartItemsState
                                                            ? Text(
                                                                '₹ ${state.cartItems[index].price * state.cartItems[index].quantity}',
                                                                style:
                                                                    semiBoldGreen,
                                                              )
                                                            : Text('Price',
                                                                style:
                                                                    semiBoldGreen,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip)
                                                      ],
                                                    ),
                                                  
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: yellowGreen
                                                                  .withOpacity(
                                                                      0.1),
                                                              borderRadius: const BorderRadius
                                                                  .horizontal(
                                                                  left: Radius
                                                                      .circular(
                                                                          10),
                                                                  right: Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    3,
                                                                    3,
                                                                    3,
                                                                    3),
                                                            child: InputQty(
                                                              decoration: const QtyDecorationProps(
                                                                  width: 10,
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              initVal: state
                                                                      is GetAllCartItemsState
                                                                  ? state
                                                                      .cartItems[
                                                                          index]
                                                                      .quantity
                                                                  : 0,
                                                              onQtyChanged:
                                                                  (value) async {
                                                                state is GetAllCartItemsState &&
                                                                        value >
                                                                            state
                                                                                .cartItems[
                                                                                    index]
                                                                                .quantity
                                                                    ? context.read<CartBloc>().add(AddToCartEvent(
                                                                        dishId: state
                                                                            .cartItems[
                                                                                index]
                                                                            .dishId,
                                                                        context:
                                                                            context))
                                                                    : state is GetAllCartItemsState &&
                                                                            value < state.cartItems[index].quantity
                                                                        ? context.read<CartBloc>().add(DecreaseCartEvent(dishId: state.cartItems[index].dishId, context: context))
                                                                        : null;
                                                              },
                                                              qtyFormProps:
                                                                  const QtyFormProps(
                                                                      enableTyping:
                                                                          false),
                                                            ),
                                                          ),
                                                        ),
                                                        // const VerticalDivider(),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              state is GetAllCartItemsState
                                                                  ? context.read<CartBloc>().add(DeleteItemFromCartEvent(
                                                                      dishId: state
                                                                          .cartItems[
                                                                              index]
                                                                          .dishId,
                                                                      context:
                                                                          context))
                                                                  : null;
                                                            },
                                                            icon:
                                                                CircleAvatar(
                                                              radius: 18,
                                                              backgroundColor:
                                                                  black.withOpacity(
                                                                      0.05),
                                                              foregroundColor:
                                                                  red,
                                                              child:
                                                                  const Icon(
                                                                Icons.delete,
                                                                size: 25,
                                                              ),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) {
                                              return divider1;
                                            },
                                            itemCount:
                                                state is GetAllCartItemsState
                                                    ? state.cartItems.length
                                                    : 0,
                                          );
                                  },
                                );
  }