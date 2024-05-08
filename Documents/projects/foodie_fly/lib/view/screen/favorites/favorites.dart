import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/api_sevices/sellers/api_calling.dart';

import 'package:foodie_fly/controller/blocs/favorites/favorites_bloc.dart';
import 'package:foodie_fly/model/seller.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/dish_detatils/screen_dish_details.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<FavoritesBloc>().add(GetAllFavoritesEvent());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(title: 'Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return state.dishes.isEmpty
                ? const Center(child: Text('Favorite List is Empty',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: width / height / .55,
                    ),
                    itemBuilder: (context, index) {
                      final dishIds =
                          state.dishes.map((dish) => dish.dishId).toList();
                      return InkWell(
                        onTap: () async {
                          Seller? seller = await SellerApiServices()
                              .getSellerById(state.dishes[index].sellerId);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ScreenDishDetails(
                                dish: state.dishes[index],
                                seller: seller!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          // height: height/2,
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.only(right: 12, top: 8),
                          decoration: BoxDecoration(
                            // color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: .5, color: yellowGreen),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: height * .14,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: .5, color: yellowGreen),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.dishes[index].imageUrl),
                                        fit: BoxFit.cover)),
                              ),
                              kHight10,
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.dishes[index].name,
                                          style: semiBoldBlack,
                                          overflow: TextOverflow.fade,
                                        ),
                                        Text('₹ ${state.dishes[index].price}',style: boldGreen,)
                                      ],
                                    ),
                                    BlocBuilder<FavoritesBloc, FavoritesState>(
                                      builder: (context, state) {
                                        return CircleAvatar(
                                          radius: 16,
                                          backgroundColor: dishIds.contains(
                                                  state.dishes[index].dishId)
                                              ? red
                                              : white,
                                          child: IconButton(
                                            onPressed: () async {
                                              context.read<FavoritesBloc>().add(
                                                  DeleteFromFavoritesEvent(
                                                      dishId: state
                                                          .dishes[index].dishId,
                                                      context: context));
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              size: 16,
                                              color: dishIds.contains(
                                                      state.dishes[index].dishId)
                                                  ? white
                                                  : red,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.dishes.length,
                  );
          },
        ),
      ),
    );
  }
}
