part of 'category_bloc.dart';

 class CategoryState {
 final List<Category> categories;
 final bool isLoading;
  CategoryState({required this.categories,this.isLoading = false});

    CategoryState copyWith({
    List<Category>? categories,
    bool? isLoading,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}



final class CategoryInitial extends CategoryState {
  CategoryInitial(): super(categories: [],isLoading: true);
}
