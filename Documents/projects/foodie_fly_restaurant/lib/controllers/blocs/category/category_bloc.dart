

import 'package:bloc/bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/categories/api_calling.dart';
import 'package:foodie_fly_restaurant/models/category.dart';


part 'category_event.dart';
part 'category_state.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      List<Category> categories =
          await CategoriesApiServices().getAndFetchAllCategories();
      emit(CategoryState(categories: categories, isLoading: false));
    });
  }
}
