part of 'restaurant_bloc.dart';
 class RestaurantEvent {}
 class SearchRestaurantEvent extends RestaurantEvent{
  final String query;

  SearchRestaurantEvent({required this.query});

 }

 class GetRestaurantByEvent extends RestaurantEvent{
  final int sellerId;

  GetRestaurantByEvent({required this.sellerId});

 }
