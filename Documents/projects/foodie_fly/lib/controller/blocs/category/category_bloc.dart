import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:foodie_fly/controller/api_sevices/categories/api_calling.dart';
import 'package:foodie_fly/model/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetAllCategoriesEvent>(_getAllCategoriesEvent);
  }

  FutureOr<void> _getAllCategoriesEvent(
      GetAllCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryState(categories: state.categories, isLoading: true));
    try {
      final categories = await CategoriesApiServices().fetchAllCategories();
      emit(CategoryState(categories: categories, isLoading: false));
    } catch (e) {
      emit(CategoryState(categories: [], isLoading: false));
    }
  }
}
