import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/category/category_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly_restaurant/models/category.dart';
import 'package:foodie_fly_restaurant/models/dish.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';
import 'package:foodie_fly_restaurant/views/screens/category/widget/dish_circle_avatar.dart';
import 'package:foodie_fly_restaurant/views/screens/category/widget/dish_trailling.dart';
import 'package:foodie_fly_restaurant/views/screens/dish/screen_dish.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/app_bar_widget.dart';

class ActionScreenCategory extends StatelessWidget {
  const ActionScreenCategory({
    super.key,
    required this.category,
  });
  final Category category;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<CategoryBloc>().add(CategoryEvent());
    context
        .read<DishBloc>()
        .add(GetDishesByCategoryEvent(categoryId: category.id!));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(title: category.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // kHight10,
            Expanded(
              child: BlocBuilder<DishBloc, DishState>(
                builder: (context, state) {
                  return state is GetDishesByCategoryState &&
                          state.dishes.isEmpty
                      ? Center(
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(
                                text: 'The Category: ', style: boldBlack),
                            TextSpan(text: category.name, style: boldGrey),
                            const TextSpan(text: ' is Empty', style: boldBlack),
                          ])),
                        )
                      : ListView.builder(
                          itemCount: state is GetDishesByCategoryState
                              ? state.dishes.length
                              : 0,
                          itemBuilder: (context, index) {
                            final dish = DishModel();
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.7, color: yellow)),
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ScreenDish(
                                            dish: state
                                                    is GetDishesByCategoryState
                                                ? state.dishes[index]
                                                : dish,
                                          ),
                                        ),
                                      );
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    leading: state is GetDishesByCategoryState
                                        ? DishCircleAvatar(
                                            width: width,
                                            height: height,
                                            imageProvider: NetworkImage(
                                              state.dishes[index].image!
                                                  .toString(),
                                            ),
                                          )
                                        : DishCircleAvatar(
                                            width: width,
                                            height: height,
                                            imageProvider: const ImageIcon(
                                                    AssetImage(
                                                        'assets/icons/foods.png'))
                                                as ImageProvider,
                                          ),
                                    title: Text(
                                      state is GetDishesByCategoryState
                                          ? state.dishes[index].name!
                                          : '',
                                      style: boldBlack,
                                    ),
                                    subtitle: Text(
                                      state is GetDishesByCategoryState
                                          ? '₹ ${state.dishes[index].price.toString()}'
                                          : '',
                                      style: semiBoldGrey,
                                    ),
                                    trailing: DishTrailingOparations(
                                      width: width,
                                      dish: dish,
                                      category: category,
                                      index: index,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: orange, width: 1),
                                    ),
                                  ),
                                
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
