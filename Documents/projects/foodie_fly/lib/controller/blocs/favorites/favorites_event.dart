part of 'favorites_bloc.dart';

class FavoritesEvent {}

final class AddToFavoritesEvent extends FavoritesEvent {
  final int dishId;
  
  AddToFavoritesEvent({required this.dishId,});
}

final class DeleteFromFavoritesEvent extends FavoritesEvent {
  final int dishId;
  

  DeleteFromFavoritesEvent({required this.dishId, required BuildContext context,});
}

final class GetAllFavoritesEvent extends FavoritesEvent {}

