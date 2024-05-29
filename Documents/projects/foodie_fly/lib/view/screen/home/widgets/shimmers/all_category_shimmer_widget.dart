import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  final double height;
  final double width;

  const CategoryShimmer({required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 15
        ),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.green.shade100,
            highlightColor: Colors.green.shade50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height * 1.7 / 10,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                const SizedBox(height: 8,width: 8,),
                Container(
                  height: 16,
                  width: width / 3,
                   decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(5)
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

