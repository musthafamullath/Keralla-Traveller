part of 'cart_bloc.dart';

class CartState {}

final class CartInitial extends CartState {}

final class GetAllCartItemsState extends CartState {
  final List<CartItem> cartItems;
  final int total;
  final String couponCode;
  final int discount;
  GetAllCartItemsState(
      {required this.cartItems,
      required this.total,
      required this.discount,
      required this.couponCode});
}

final class AddToCartState extends CartState {}

final class GetAllCartItemsFaildState extends CartState{}

final class GetAllCouponsState extends CartState {
  final List<Coupon> coupons;
  GetAllCouponsState({required this.coupons});
}

final class RedeemCouponState extends CartState {
  final int actualTotal;
  final int redeemAmount;
  RedeemCouponState({required this.actualTotal, required this.redeemAmount});
}

final class CheckOutSuccessState extends CartState{}
final class CheckOutFaildState extends CartState{}
