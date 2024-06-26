import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/cart/cart_bloc.dart';
import 'package:foodie_fly/model/dish.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/dish_detatils/widget/favorites_button.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.width,
    required this.height,
    required this.dish,
  });

  final double width;
  final double height;
  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: width *4/10,
          height: height * 0.5/10,
          child: ElevatedButton.icon(
            onPressed: () async {
              context
                  .read<CartBloc>()
                  .add(AddToCartEvent(dishId: dish.dishId, context: context));
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
              size: 32,
              color: white,
            ),
            label: const Text(
              'Add to bag',
              style: regularWhite,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: yellowGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
        FavoritesButton(
          dish: dish,
        )
      ],
    );
  }
}
