import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodie_fly/controller/api_sevices/favorites/api_calling.dart';
import 'package:foodie_fly/model/dish.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<GetAllFavoritesEvent>(_getAllFavoritesEvent);
    on<AddToFavoritesEvent>(_addToFavoritesEvent);
    on<DeleteFromFavoritesEvent>(_deleteFromFavoritesEvent);
  }

  FutureOr<void> _getAllFavoritesEvent(
      GetAllFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    try {
      List<Dish> dishes = await FavoriteApiServices().getAllFavorites();
      emit(FavoritesLoaded(dishes: dishes, dishId: 0));
    } catch (e) {
      emit(FavoritesError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _addToFavoritesEvent(
      AddToFavoritesEvent event, Emitter<FavoritesState> emit) async {
    // emit(FavoritesLoading());
    try {
      final value = await FavoriteApiServices().addToFavorite(event.dishId);
      if (value) {
        final dishes = await FavoriteApiServices().getAllFavorites();
        emit(FavoritesLoaded(dishes: dishes, dishId: event.dishId));
      } else {
        await FavoriteApiServices().deleteFromFovorites(event.dishId);
        final dishes = await FavoriteApiServices().getAllFavorites();
        emit(FavoritesLoaded(dishes: dishes, dishId: event.dishId));
      }
    } catch (e) {
      emit(FavoritesError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _deleteFromFavoritesEvent(
      DeleteFromFavoritesEvent event, Emitter<FavoritesState> emit) async {
    // emit(FavoritesLoading());
    try {
      final value = await FavoriteApiServices().deleteFromFovorites(event.dishId);
      if (value) {
        final dishes = await FavoriteApiServices().getAllFavorites();
        emit(FavoritesLoaded(dishes: dishes, dishId: event.dishId));
      }
    } catch (e) {
      emit(FavoritesError(errorMessage: e.toString()));
    }
  }
}
