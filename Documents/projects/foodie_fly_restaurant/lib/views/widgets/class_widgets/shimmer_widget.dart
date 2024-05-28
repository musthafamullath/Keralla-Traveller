import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerClass extends StatelessWidget {
  const ShimmerClass({
    super.key, 
  });


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor:Colors.yellow.shade300,
          highlightColor: Colors.yellow.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}