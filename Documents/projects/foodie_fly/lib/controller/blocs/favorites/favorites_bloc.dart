// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodie_fly/controller/api_sevices/favorites/api_calling.dart';
import 'package:foodie_fly/model/dish.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<GetAllFavoritesEvent>(getAllFavoritesEvent);
    on<AddToFavoritesEvent>(addToFavoritesEvent);
    on<DeleteFromFavoritesEvent>(deleteFromFavoritesEvent);
  }

  FutureOr<void> getAllFavoritesEvent(GetAllFavoritesEvent event, Emitter<FavoritesState> emit)async {
    List<Dish> dishes = await FavoriteApiServices().getAllFavorites();
    emit(FavoritesState(dishes: dishes, dishId: 0));
  }

  FutureOr<void> addToFavoritesEvent(AddToFavoritesEvent event, Emitter<FavoritesState> emit)async {
    final value = await FavoriteApiServices().addToFavorite(event.dishId);
    if(value){
      final dishes = await FavoriteApiServices().getAllFavorites();
      emit(FavoritesState(dishes: dishes, dishId: event.dishId));
      emit(AddTofavorite());
    }else{
      await FavoriteApiServices().deleteFromFovorites(event.dishId);
      final dishes = await FavoriteApiServices().getAllFavorites();
      emit(FavoritesState(dishes: dishes, dishId:event.dishId));
      emit(DeleteFromFavorite());
    }
  }

  FutureOr<void> deleteFromFavoritesEvent(DeleteFromFavoritesEvent event, Emitter<FavoritesState> emit)async {
    final value = await FavoriteApiServices().deleteFromFovorites(event.dishId);
    if(value){
      final dishes = await FavoriteApiServices().getAllFavorites();
      emit(FavoritesState(dishes: dishes, dishId:event.dishId));
      emit(DeleteFromFavorite());       
    }else{

    }
  }
}
