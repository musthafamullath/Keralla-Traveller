part of 'restaurant_bloc.dart';

class RestaurantState {
  final List<Seller> restaurants;
  final Seller? seller;
  final bool isLoading;

  RestaurantState({required this.restaurants, this.seller, this.isLoading = false});
}

class RestaurantInitial extends RestaurantState {
  RestaurantInitial() : super(restaurants: []);
}

class RestaurantLoading extends RestaurantState {
  RestaurantLoading() : super(restaurants: [], isLoading: true);
}

class RestaurantLoaded extends RestaurantState {
  RestaurantLoaded({required super.restaurants, super.seller});
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError({required this.message}) : super(restaurants: []);
}
