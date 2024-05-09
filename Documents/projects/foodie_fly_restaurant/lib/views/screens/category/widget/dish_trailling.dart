import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/dish/api_calling.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/screen_add_dishes.dart';

class DishTrailingOparations extends StatelessWidget {
  const DishTrailingOparations({
    super.key,
    required this.width,
    required this.dish,
    required this.category, required this.index,
  });

  final double width;
  final DishModel dish;
  final Category category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width *3/10,
      
      child: BlocBuilder<CategoryBloc,
          CategoryState>(
        builder: (context, state) {
          final categories = state.categories;
          return Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<DishBloc, DishState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ScreenAddDishes(
                            categories:
                                categories,
                            dishModel: state
                                    is GetDishesByCategoryState
                                ? state
                                    .dishes[index]
                                : dish,
                            operatior:
                                Operatior.edit,
                          ),
                        ),
                      );
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      child: const Icon(
                        CupertinoIcons
                            .eyedropper_halffull,
                        size: 22,
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<DishBloc, DishState>(
                builder: (context, state) {
                  return state
                          is GetDishesByCategoryState
                      ? IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder:
                                    (context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Delete'),
                                    content:
                                        const Text(
                                            'Are you sure to delete?'),
                                    actions: [
                                      BlocBuilder<
                                          DishBloc,
                                          DishState>(
                                        builder: (
                                          context,
                                          state,
                                        ) {
                                          return state
                                                  is GetDishesByCategoryState
                                              ? TextButton(
                                                  child: const Text('Delete'),
                                                  onPressed: () async {
                                                    await DishApiServices().deleteDish(state.dishes[index].dishId!).then(
                                                          (value) => context.read<DishBloc>().add(
                                                                GetDishesByCategoryEvent(
                                                                  categoryId: category.id!,
                                                                ),
                                                              ),
                                                        );
    
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              : const SizedBox();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                            'Cancel'),
                                        onPressed:
                                            () async {
                                          Navigator.pop(
                                              context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            child: const Icon(
                              CupertinoIcons.delete,
                              size: 22,
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
