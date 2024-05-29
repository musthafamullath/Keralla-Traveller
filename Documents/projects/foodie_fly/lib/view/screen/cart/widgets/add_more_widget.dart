import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/screen/restaurants/widgets/restaurant_dishes.dart';

class Addmorewidget extends StatelessWidget {
  const Addmorewidget({
    super.key,
    required this.sellerId,
  });

  final int sellerId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        const SectionHead(
            heading: 'Add more items'),
        BlocBuilder<RestaurantBloc,
            RestaurantState>(
          builder: (context, state) {
            return IconButton(
                onPressed: () {
                  if (sellerId != 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ScreenRestaurantDishes(
                          seller: state
                              .restaurants
                              .firstWhere(
                                  (element) =>
                                      element
                                          .id ==
                                      sellerId),
                        ),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ScreenMainPage(),
                      ),
                    );
                  }
                },
                icon: const Icon(
                  CupertinoIcons.add_circled,
                  size: 32,
                ));
          },
        )
      ],
    );
  }
}
