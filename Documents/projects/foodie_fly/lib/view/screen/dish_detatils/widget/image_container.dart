import 'package:flutter/material.dart';
import 'package:foodie_fly/model/dish.dart';
import 'package:foodie_fly/utils/constants.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
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
    return Container(
  width: width,
  height: height * .3,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(width: 5,color: white),
    color: Colors.green,
    image: DecorationImage(
      image: dish.imageUrl.isEmpty
          ?  const AssetImage('assets/icons/restaurant.png')
          : NetworkImage(dish.imageUrl)as ImageProvider<Object>,
      fit: BoxFit.cover,
    ),
  ),
);

  }
}
