import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/model/offer.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
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
    final pictureSizewidth = MediaQuery.of(context).size.width;
    for (int i = 0; i < offers.length; i++) {
      context
          .read<RestaurantBloc>()
          .add(GetRestaurantByEvent(sellerId: offers[i].sellerId));
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      height: height * .38,
      width: width * 1,
      child: CarouselSlider.builder(
        itemCount: offers.length,
        itemBuilder: (context, index, realIndex) {
          return InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 5,left: 5, top: 5,bottom: 5),
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
                  Container(
                    height: height * .200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      
                      image: DecorationImage(
                        image: NetworkImage(offers[index].image),
                        fit: BoxFit.fill,
                      ),
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  offers[index].offerTitle,
                                  style: boldGrey,
                                )
                              ],
                            ),
                            BlocBuilder<RestaurantBloc, RestaurantState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Text(
                                      state.seller?.name ?? 'Ajwa',
                                      style: semiBoldGrey,
                                    ),
                                  ],
                                );
                              },
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  DateFormat.yMMMMd('en_US').format(
                                      DateTime.parse(offers[index].endDate)),
                                  style: semiBoldGrey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade300,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: white,
                            child: Text(
                              '${offers[index].offerPercentage.toString()}%',
                              style: semiBoldGreen,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          reverse: true,
          height: pictureSizewidth * 0.70,
          autoPlay: true,
          viewportFraction: 0.59,
          enableInfiniteScroll: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
          autoPlayAnimationDuration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
