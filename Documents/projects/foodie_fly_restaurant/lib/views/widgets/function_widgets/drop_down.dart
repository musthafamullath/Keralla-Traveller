import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/screen_add_dishes.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatelessWidget {
  DropDownWidget({
    super.key,
    required this.categories,
    required this.title,
    this.dish,
    required this.operation,
  });

  final List<Category> categories;
  final String title;
  String category = '';
  final DishModel? dish;
  final Operatior operation;

  @override
  Widget build(BuildContext context) {
    category = dish != null
        ? categories
            .firstWhere((element) => element.id == dish!.categoryId)
            .name!
        : '';
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonFormField(
        dropdownColor: Colors.grey.shade300,
        iconSize: 35,
        
        validator: (value) {  
          if (value == null) return 'Choose category';
          return null;
        },
        decoration: InputDecoration(
            label: Text(dish != null ? category : title),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),
            border: InputBorder.none),
        items: categories.map((cat) {
          return DropdownMenuItem(
            value: cat,
            child: Text(cat.name!),
          );
        }).toList(),
        onChanged: (value) async {
          category = value?.name ?? 'Biriyani';

          context.read<DishBloc>().add(
                AddCategoryEvent(
                  categoryId: value!.id!,
                ),
              );
        },
      ),
    );
  }
}
