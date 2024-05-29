part of 'favorites_bloc.dart';

class FavoritesState {
  final List<Dish> dishes;
  final int dishId;
  final bool isLoading;
  final String errorMessage;

  FavoritesState({
    required this.dishes,
    required this.dishId,
    this.isLoading = false,
    this.errorMessage = '',
  });
}

class FavoritesInitial extends FavoritesState {
  FavoritesInitial() : super(dishes: [], dishId: 0);
}

class FavoritesLoading extends FavoritesState {
  FavoritesLoading() : super(dishes: [], dishId: 0, isLoading: true);
}

class FavoritesLoaded extends FavoritesState {
  FavoritesLoaded({required super.dishes, required super.dishId});
}

class FavoritesError extends FavoritesState {
  FavoritesError({required super.errorMessage})
      : super(dishes: [], dishId: 0);
}
