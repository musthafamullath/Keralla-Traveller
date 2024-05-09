
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';

class DishCircleAvatar extends StatelessWidget {
  const DishCircleAvatar({
    super.key,
    required this.width,
    required this.height,
    required this.imageProvider,
  });

  final double width;
  final double height;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: yellow)),
      child: CircleAvatar(
        radius: min(
          width * .095,
          height * .095,
        ),
        backgroundImage: imageProvider,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
    );
  }
}
