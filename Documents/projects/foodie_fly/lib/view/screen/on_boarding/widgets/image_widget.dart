import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({
    super.key,
    required this.width,
    required this.height,
    required this.position,
  });

  final double width;
  final double height;
  final images = [
    'assets/images/food-apps.png',
    'assets/images/food-stall.png',
    'assets/images/order-food.png'
  ];
  final int position;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 150,
      backgroundColor: black,
      child: CircleAvatar(
        radius: 148,
        backgroundColor: white,
        child: SizedBox(
          width: width - (width * .5),
          height: height * .25,
          child: Image.asset(
            images[position],
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
