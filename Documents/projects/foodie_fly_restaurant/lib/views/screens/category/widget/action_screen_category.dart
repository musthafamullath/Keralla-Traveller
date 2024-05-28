// ignore_for_file: use_build_context_synchronously, must_be_immutable


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/dish/api_calling.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/add_dishes/screen_add_dishes.dart';
import 'package:foodie_fly_restaurant/views/screens/dish/screen_dish.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/shimmer_widget.dart';


class ActionScreenCategory extends StatelessWidget {
  ActionScreenCategory({
    super.key,
    required this.category,
  });
  final Category category;
  DishModel? dish;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<CategoryBloc>().add(FetchCategories());
    context
        .read<DishBloc>()
        .add(GetDishesByCategoryEvent(categoryId: category.id));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(title: category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<DishBloc, DishState>(
                buildWhen: (previous, current) =>
                    current is GetDishesByCategoryState,
                builder: (context, state) {
                  if (state is GetDishesByCategoryState && state.isLoading) {
                    return BlocBuilder<DishBloc, DishState>(
                      builder: (context, state) {
                        return const ShimmerClass(
                         
                        );
                      },
                    );
                  } else if (state is GetDishesByCategoryState &&
                      state.dishes.isEmpty) {
                    return Center(
                      child: Text.rich(TextSpan(children: [
                        const TextSpan(
                            text: 'The Category: ', style: boldBlack),
                        TextSpan(text: category.name, style: boldGrey),
                        const TextSpan(text: ' is Empty', style: boldBlack),
                      ])),
                    );
                  }
                  return ListView.separated(
                    itemCount: state is GetDishesByCategoryState
                        ? state.dishes.length
                        : 0,
                    itemBuilder: (context, index) {
                      dish = state is GetDishesByCategoryState
                          ? state.dishes[index]
                          : null;
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.7, color: yellow)),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ScreenDish(
                                      dish: state is GetDishesByCategoryState
                                          ? state.dishes[index]
                                          : dish,
                                    ),
                                  ),
                                );
                              },
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              leading: Container(
                                width: width * .15,
                                height: height * .075,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: dish!.image == ''
                                          ? const AssetImage(
                                                  'assets/images/categories/dish.jpg')
                                              as ImageProvider
                                          : NetworkImage(dish!.image),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              title: Text(
                                state is GetDishesByCategoryState
                                    ? state.dishes[index].name
                                    : '',
                                style: boldBlack,
                              ),
                              subtitle: Text(
                                state is GetDishesByCategoryState
                                    ? '₹ ${state.dishes[index].price.toString()}'
                                    : '',
                                style: semiBoldGrey,
                              ),
                              trailing: SizedBox(
                                width: width * .3,
                                child: BlocBuilder<CategoryBloc, CategoryState>(
                                  builder: (context, state) {
                                    final categories = state.categories;
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BlocBuilder<DishBloc, DishState>(
                                          builder: (context, state) {
                                            return IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScreenAddDishes(
                                                      categories: categories,
                                                      operatior: Operatior.edit,
                                                      dish: state
                                                              is GetDishesByCategoryState
                                                          ? state.dishes[index]
                                                          : dish,
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: CircleAvatar(
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.1),
                                                child: const Icon(
                                                  CupertinoIcons
                                                      .eyedropper_halffull,
                                                  size: 22,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text('Delete'),
                                                    content: const Text(
                                                        'Are you sure to delete?'),
                                                    actions: [
                                                      BlocBuilder<DishBloc,
                                                          DishState>(
                                                        builder: (
                                                          context,
                                                          state,
                                                        ) {
                                                          return state
                                                                  is GetDishesByCategoryState
                                                              ? TextButton(
                                                                  child: const Text(
                                                                      'Delete'),
                                                                  onPressed:
                                                                      () async {
                                                                    await DishApiServices()
                                                                        .deleteDish(state
                                                                            .dishes[index]
                                                                            .dishId)
                                                                        .then(
                                                                          (value) => context
                                                                              .read<DishBloc>()
                                                                              .add(
                                                                                GetDishesByCategoryEvent(
                                                                                  categoryId: category.id,
                                                                                ),
                                                                              ),
                                                                        );

                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
                                                              : const SizedBox();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            'Cancel'),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.1),
                                            child: const Icon(
                                              CupertinoIcons.delete,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: orange, width: 1),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return kHight20;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
