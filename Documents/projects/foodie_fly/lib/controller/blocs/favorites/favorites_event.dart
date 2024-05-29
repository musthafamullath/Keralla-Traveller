part of 'favorites_bloc.dart';

class FavoritesEvent {}

class AddToFavoritesEvent extends FavoritesEvent {
  final int dishId;

  AddToFavoritesEvent({required this.dishId});
}

class DeleteFromFavoritesEvent extends FavoritesEvent {
  final int dishId;

  DeleteFromFavoritesEvent({required this.dishId});
}

class GetAllFavoritesEvent extends FavoritesEvent {}
