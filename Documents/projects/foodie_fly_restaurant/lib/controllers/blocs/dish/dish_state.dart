part of 'dish_bloc.dart';


class DishState {
  final bool isLoading;

  DishState({required this.isLoading});

}

final class DishInitial extends DishState {
  DishInitial(): super(isLoading: false);
}

final class AddVegState extends DishState {
  final bool isVeg;

  AddVegState({required this.isVeg,super.isLoading = false});
}

final class AddAvailState extends DishState {
  final bool isAvail;

  AddAvailState({required this.isAvail,super.isLoading = false});
}

final class AddCategoryState extends DishState {
  final int categoryId;

  AddCategoryState({required this.categoryId,super.isLoading = false});
}

final class AddNewDishState extends DishState {
   AddNewDishState({super.isLoading = false});
}

final class UpdateDishState extends DishState {
  
  UpdateDishState({super.isLoading = false});
}

final class DishLoadingState extends DishState{
  DishLoadingState({super.isLoading = true});
  
}

final class GetDishesByCategoryState extends DishState {
  final List<DishModel> dishes;

  GetDishesByCategoryState({required this.dishes,super.isLoading = false});
}
