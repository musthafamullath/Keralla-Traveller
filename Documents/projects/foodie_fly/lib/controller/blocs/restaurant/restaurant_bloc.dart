import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodie_fly/controller/api_sevices/sellers/api_calling.dart';
import 'package:foodie_fly/model/seller.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial()) {
    on<RestaurantEvent>(restaurantEvent);
    on<SearchRestaurantEvent>(searchRestaurantEvent);
    on<GetRestaurantByEvent>(getRestaurantByEvent);
  }

  FutureOr<void> restaurantEvent(
      RestaurantEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      List<Seller> restaurants = await SellerApiServices().fetchAllSellers();
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }

  FutureOr<void> searchRestaurantEvent(
      SearchRestaurantEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      List<Seller> restaurants =
          await SellerApiServices().searchSeller(event.query);
      emit(RestaurantLoaded(restaurants: restaurants));
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }

  FutureOr<void> getRestaurantByEvent(
      GetRestaurantByEvent event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurant =
          await SellerApiServices().getSellerById(event.sellerId);
      if (restaurant == null) {
        final fallbackRestaurant = Seller(
          id: 0,
          name: "name",
          description: 'description',
          email: "email",
          pinCode: "pincode",
        );
        List<Seller> restaurants =
            await SellerApiServices().fetchAllSellers();
        emit(RestaurantLoaded(restaurants: restaurants, seller: fallbackRestaurant));
      } else {
        List<Seller> restaurants =
            await SellerApiServices().fetchAllSellers();
        emit(RestaurantLoaded(restaurants: restaurants, seller: restaurant));
      }
    } catch (e) {
      emit(RestaurantError(message: e.toString()));
    }
  }
}
