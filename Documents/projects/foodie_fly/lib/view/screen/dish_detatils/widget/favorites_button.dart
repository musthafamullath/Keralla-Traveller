import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie_fly/controller/blocs/favorites/favorites_bloc.dart';
import 'package:foodie_fly/model/dish.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';

class FavoritesButton extends StatelessWidget {
  const FavoritesButton({super.key, required this.dish});

  final Dish dish;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesLoaded) {
          showSnack(context, kGreen, "Added To Favarite");
        } else if (state is FavoritesError) {
          showSnack(context, Colors.red, "Failed to update favorites");
        } else if (state is FavoritesLoading) {
          const Padding(
            padding:  EdgeInsets.only(top: 250),
            child: Center(
              child: Column(
                children: [
                  SpinKitCircle(
                    color: yellowGreen,
                  ),
                  Text(
                    "Pls Wait",
                    style: regularGrey,
                  )
                ],
              ),
            ),
          );
        }else{
          
        }
      },
      builder: (context, state) {
        final dishIds = state.dishes.map((dish) => dish.dishId).toList();
        return CircleAvatar(
          radius: 26,
          child: CircleAvatar(
            backgroundColor:
                dishIds.contains(dish.dishId) ? yellowGreen : white,
            radius: 24,
            child: IconButton(
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
              onPressed: () {
                if (dishIds.contains(dish.dishId)) {
                  context.read<FavoritesBloc>().add(
                        AddToFavoritesEvent(dishId: dish.dishId),
                      );
                } else {
                  context
                      .read<FavoritesBloc>()
                      .add(AddToFavoritesEvent(dishId: dish.dishId));
                }
              },
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: dishIds.contains(dish.dishId) ? white : yellowGreen,
              ),
            ),
          ),
        );
      },
    );
  }
}
