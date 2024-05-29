import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/model/offer.dart';
import 'package:foodie_fly/model/seller.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/offer_details/widget/offer_shimmer.dart';
import 'package:intl/intl.dart';


class ScreenOffer extends StatelessWidget {
  const ScreenOffer({
    super.key,
    required this.height,
    required this.width,
    required this.offers,
  });
  final double height;
  final double width;
  final List<Offer> offers;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < offers.length; i++) {
      context
          .read<RestaurantBloc>()
          .add(GetRestaurantByEvent(sellerId: offers[i].sellerId));
    }

    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return OfferShimmer(height: height, width: width);
        }
        if (state is RestaurantLoaded) {
          return state.restaurants.isEmpty
          ? const Center(
            child: Text("Offer is Empty"),
          ):
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            height: height * .38,
            width: width * 1,
            child: CarouselSlider.builder(
              itemCount: offers.length,
              itemBuilder: (context, index, realIndex) {
                final offerItem = offers[index];
                final restaurant = state.restaurants.firstWhere(
                  (restaurant) => restaurant.id == offerItem.sellerId,
                  orElse: () => Seller(
                    id: 0,
                    name: '',
                    description: '',
                    email: '',
                    pinCode: '',
                  ),
                );
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: width - (width * .35),
                  height: height * 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: white,
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            height: height * .20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(offerItem.image),
                                fit: BoxFit.fill,
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
                      kHight20,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      offerItem.offerTitle,
                                      style: regularGrey,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      restaurant.name,
                                      style: regularGrey,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      DateFormat.yMMMMd('en_US').format(
                                          DateTime.parse(offerItem.endDate)),
                                      style: regularGrey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                reverse: true,
                height: width * 0.70,
                autoPlay: true,
                viewportFraction: 0.60,
                enableInfiniteScroll: true,
                pageSnapping: true,
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                autoPlayAnimationDuration: const Duration(seconds: 3),
              ),
            ),
          );
        } else {
          return const Center(child: Text("Failed to load offers"));
        }
      },
    );
  }
}

