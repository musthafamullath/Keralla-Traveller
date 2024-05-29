import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(
          vertical: 7.5,
          horizontal: 7.5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
      ),
    );
  }
}
