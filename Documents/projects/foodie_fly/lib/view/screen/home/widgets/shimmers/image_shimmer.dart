import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerStackEffect extends StatelessWidget {
  final double height;

  const ShimmerStackEffect({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.green.shade100,
            highlightColor: Colors.green.shade50,
            child: Container(
              height: height * .13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.shade900, // Placeholder color
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 15,
          child: Shimmer.fromColors(
            baseColor: Colors.green.shade200,
            highlightColor: Colors.green.shade50,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green.shade50,
              child: CircleAvatar(
                radius: 19,
                backgroundColor: Colors.green.shade300,
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.green.shade900, // Placeholder color
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
