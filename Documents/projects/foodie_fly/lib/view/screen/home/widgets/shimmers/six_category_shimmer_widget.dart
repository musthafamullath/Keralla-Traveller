import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  final double height;
  final double width;

  const CategoryShimmer({required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.green.shade100,
          highlightColor: Colors.green.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * 1 / 10,
                width: width * 5.8 / 10,
                decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15)
                ),
                
              ),
              const SizedBox(height: 8,width: 8,),
              Container(
               height: height * 0.1 / 10,
                width: width * 5.8 / 10,
                decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15)
                )
              ),
            ],
          ),
        );
      },
    );
  }
}
