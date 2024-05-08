import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/favorites/favorites_bloc.dart';
import 'package:foodie_fly/model/dish.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';

class FavoritesButton extends StatelessWidget {
  const FavoritesButton({super.key, required this.dish});
  
  final Dish dish;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        
       if(state is AddTofavorite){
        showSnack(context, kGreen, "Added To Favarite");
       }else{}
      },
      builder: (context, state) {
        final dishIds = state.dishes.map((dish) => dish.dishId).toList();
        return CircleAvatar(
          radius: 26,
          child: CircleAvatar(
            backgroundColor: dishIds.contains(dish.dishId)
            ?
            yellowGreen
            :
            white,
            radius: 24,
            child: IconButton(
              style: ElevatedButton.styleFrom(
                  shape:const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
              onPressed: () {
                context.read<FavoritesBloc>().add(
                  AddToFavoritesEvent(dishId: dish.dishId)
                );
              },
              icon: Icon(
                Icons.favorite,
                size: 30,
                color: dishIds.contains(dish.dishId)
                ?
                white
                :
                yellowGreen,
              ),
            ),
          ),
        );
      },
    );
  }
}
