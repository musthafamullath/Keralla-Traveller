

// ignore_for_file: implementation_imports, unnecessary_import, use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodie_fly/controller/api_sevices/cart/api_calling.dart';
import 'package:foodie_fly/controller/api_sevices/checkout/api_calling.dart';
import 'package:foodie_fly/controller/api_sevices/coupon/api_calling.dart';
import 'package:foodie_fly/model/cart_item.dart';
import 'package:foodie_fly/model/checkout.dart';
import 'package:foodie_fly/model/coupon.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/screen/payment/screen_payment.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';

part 'cart_event.dart';
part 'cart_state.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  int discount = 0;

  CartBloc() : super(CartInitial()) {
    on<GetAllCartItemsEvent>((event, emit) async {
      emit(CartLoading());
      List<CartItem> cartItems = await CartApiService().getAllCartItems();
      final total = sum(cartItems);
      emit(GetAllCartItemsState(
          cartItems: cartItems,
          total: total,
          discount: discount,
          couponCode: ''));
    });

    on<AddToCartEvent>((event, emit) async {
      // emit(CartLoading());
      final value = await CartApiService().addToCart(event.dishId);
      final cartItems = await CartApiService().getAllCartItems();
      final total = sum(cartItems);
      if (value) {
        showSnack(event.context, Colors.green, 'Added to cart');
        emit(GetAllCartItemsState(
            cartItems: cartItems,
            total: total,
            discount: discount,
            couponCode: ''));
      } else {
        showSnack(
            event.context, Colors.red, 'Select dish from same restaurant.');
      }
    });

    on<DecreaseCartEvent>((event, emit) async {
      // emit(CartLoading());
      final value = await CartApiService().decreaseFromCart(event.dishId);
      final cartItems = await CartApiService().getAllCartItems();
      int total = sum(cartItems);
      if (value) {
        showSnack(event.context, Colors.green, 'Decreased from cart');
        emit(GetAllCartItemsState(
            cartItems: cartItems,
            total: total,
            discount: discount,
            couponCode: ''));
      } else {
        showSnack(
            event.context, Colors.red, 'Choose dish from same restaurant.');
      }
    });

    on<DeleteItemFromCartEvent>((event, emit) async {
      // emit(CartLoading());
      final value = await CartApiService().deleteItemFromCart(event.dishId);
      final cartItems = await CartApiService().getAllCartItems();
      int total = sum(cartItems);
      if (value) {
        showSnack(event.context, Colors.green, 'Removed from cart');
        emit(GetAllCartItemsState(
            cartItems: cartItems,
            total: total,
            discount: discount,
            couponCode: ''));
      } else {
        showSnack(
            event.context, Colors.red, 'Select dish from same restaurant.');
      }
    });

    on<GetAllCouponsEvent>((event, emit) async {
      // emit(CartLoading());
      final coupons = await CouponApiServices().getAllCoupons();
      emit(GetAllCouponsState(coupons: coupons));
    });

    on<GetAvailableCouponsEvent>((event, emit) async {
      // emit(CartLoading());
      final coupons = await CouponApiServices().getAvailableCoupons();
      emit(GetAllCouponsState(coupons: coupons));
    });

    on<RedeemCouponEvent>((event, emit) async {
      // emit(CartLoading());
      final coupons = await CouponApiServices().getAvailableCoupons();
      final cartItems = await CartApiService().getAllCartItems();
      int total = sum(cartItems);
      if (event.coupon.minimumAmtRequired < total) {
        discount = event.coupon.discount;
        emit(GetAllCouponsState(coupons: coupons));
        emit(GetAllCartItemsState(
          cartItems: cartItems,
          total: total,
          discount: discount,
          couponCode: event.coupon.couponCode,
        ));
      }
    });

    on<CheckoutEvent>((event, emit) async {
      // emit(CartLoading());
      final value = await CheckOutApiServices().checkOut(event.checkOut);
      if (value == null) {
        showSnack(event.context, Colors.green, 'Order Placed Successfully.');
        Navigator.of(event.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ScreenMainPage()),
            (route) => false);
      } else {
        Navigator.of(event.context).push(
          MaterialPageRoute(
            builder: (context) => ScreenPayment(response: value),
          ),
        );
      }
    });
  }

  int sum(List<CartItem> cartItems) {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].price.round() * cartItems[i].quantity;
    }
    return total;
  }
}
