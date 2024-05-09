// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/dish/api_calling.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/main/screen_main_page.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/snackbar_function.dart';


part 'dish_event.dart';
part 'dish_state.dart';


class DishBloc extends Bloc<DishEvent, DishState> {
  DishBloc() : super(DishInitial()) {
    on<AddVegEvent>((event, emit) {
      bool value = event.isVeg;
      emit(AddVegState(isVeg: value));
    });
    on<AddAvailableEvent>((event, emit) {
      bool value = event.isAvail;
      emit(AddAvailState(isAvail: value));
    });
    on<AddCategoryEvent>((event, emit) {
      int categoryId = event.categoryId;
      emit(AddCategoryState(categoryId: categoryId));
    });
    on<AddNewDishEvent>((event, emit) async {
      emit(AddNewDishState(isLoading: true));
      final result = await DishApiServices().addDish(event.dish);
      if (result) {
       
        showSnack(event.context, Colors.green, 'Successfully Inserted.');
       
        Navigator.of(event.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ScreenMainPage()),
            (route) => false);
      } else {
        showSnack(event.context, Colors.red, 'Invalid entries');
        emit(AddNewDishState(isLoading: false));
      }
    });

    on<GetDishesByCategoryEvent>((event, emit) async {
      List<DishModel> dishes =
          await DishApiServices().fetchDishesbyCategory(event.categoryId);
          
      emit(GetDishesByCategoryState(dishes: dishes));
    });

    on<UpdateDishEvent>((event, emit) async {
      final result = await DishApiServices().updateDish(event.dishModel);
      
      if (result) {
        emit(UpdateDishState(isLoading: false));
        showSnack(event.context, Colors.green, 'Updated Successfully .');
        Navigator.pop(event.context);
      } else {
        showSnack(event.context, Colors.red, 'Not updated.');
      }
      List<DishModel> dishes = await DishApiServices()
          .fetchDishesbyCategory(event.dishModel.categoryId!);
      emit(GetDishesByCategoryState(dishes: dishes));
    });
    on<DeleteDishEvent>((event, emit) async{
      final result = await DishApiServices().deleteDish(event.dishModel.dishId!);
      
      if(result){
        emit(DeleteDishState(dishId: event.dishModel.dishId!));
        showSnack(event.context, green, "Delete successfully");
        Navigator.pop(event.context);
      }else{
        showSnack(event.context, Colors.red, 'Not deleted.');
      }
      List<DishModel> dishes = await DishApiServices()
      .fetchDishesbyCategory(event.dishModel.categoryId!);
      emit(GetDishesByCategoryState(dishes: dishes));
    },);
  }
}
