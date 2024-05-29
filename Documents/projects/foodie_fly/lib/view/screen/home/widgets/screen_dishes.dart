import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/model/offer.dart';
import 'package:foodie_fly/model/seller.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/home/widgets/shimmers/image_shimmer.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:intl/intl.dart';


class ScreenDishes extends StatelessWidget {
  const ScreenDishes({
    super.key,
    required this.height,
    required this.width,
    required this.offer,
  });

  final double height;
  final double width;
  final List<Offer> offer;

  @override
  Widget build(BuildContext context) {
    final reversedOfferList = offer.reversed.toList();
    for (int i = 0; i < reversedOfferList.length; i++) {
      context
          .read<RestaurantBloc>()
          .add(GetRestaurantByEvent(sellerId: reversedOfferList[i].sellerId));
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: "Offers"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: reversedOfferList.length,
                itemBuilder: (context, index) {
                  return ShimmerStackEffect(height: height);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              );
            } else if (state is RestaurantLoaded) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: reversedOfferList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final offerItem = reversedOfferList[index];
                  final restaurant = state.restaurants.firstWhere(
                    (restaurant) => restaurant.id == offerItem.sellerId,
                    orElse: () {
                      return Seller(
                        id: 0,
                        name: '',
                        description: '',
                        email: '',
                        pinCode: '',
                      );
                    },
                  );

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 7.5,
                      horizontal: 7.5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              height: height * .13,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(offerItem.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 7.5,
                              top: 7.5,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade300,
                                child: CircleAvatar(
                                  radius: 19,
                                  backgroundColor: Colors.black.withOpacity(0.9),
                                  child: Text(
                                    '${offerItem.offerPercentage.toString()}%',
                                    style: regularGreen,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Text(
                                    offerItem.offerTitle,
                                    style: regularGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                restaurant.name,
                                style: regularGrey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(offerItem.endDate)),
                                style: regularGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              );
            } else if (state is RestaurantError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Unknown state',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

