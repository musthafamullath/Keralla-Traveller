import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/api_sevices/sellers/api_calling.dart';
import 'package:foodie_fly/controller/blocs/favorites/favorites_bloc.dart';
import 'package:foodie_fly/model/seller.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/dish_detatils/screen_dish_details.dart';
import 'package:foodie_fly/view/screen/favorites/widgets/favorite_shimmer.dart';
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
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: 'Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return FavoriteShimmer(width: width, height: height);
            } else if (state is FavoritesError) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            } else if (state is FavoritesLoaded) {
              if (state.dishes.isEmpty) {
                return const Center(
                  child: Text(
                    'Favorite List is Empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return GridView.builder(
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
                        margin:
                            const EdgeInsets.only(top: 15, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: .5, color: yellowGreen),
                        ),
                        child: Column(
                          children: [
                            Stack(
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
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: BlocBuilder<FavoritesBloc,
                                      FavoritesState>(
                                    builder: (context, state) {
                                      return CircleAvatar(
                                        radius: 16,
                                        backgroundColor: dishIds.contains(
                                                state.dishes[index].dishId)
                                            ? white
                                            : black,
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: black.withOpacity(0.5),
                                          child: IconButton(
                                            onPressed: () async {
                                              context
                                                  .read<FavoritesBloc>()
                                                  .add(DeleteFromFavoritesEvent(
                                                    dishId: state
                                                        .dishes[index].dishId,
                                                  ));
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              size: 15,
                                              color: dishIds.contains(
                                                      state.dishes[index].dishId)
                                                  ? white
                                                  : red,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            kHight10,
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.dishes[index].name,
                                        style: regularBlack,
                                        overflow: TextOverflow.fade,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹ ${state.dishes[index].price}',
                                            style: boldGreen,
                                          ),
                                          kWidth20,
                                          kWidth20,
                                          // Add this line for spacing
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.dishes.length,
                );
              }
            } else {
              return const Center(
                child: Text(
                  'Unknown State',
                  style: semiBoldBlack,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
