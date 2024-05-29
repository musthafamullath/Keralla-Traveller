import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteShimmer extends StatelessWidget {
  const FavoriteShimmer({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 10),
      child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: width / height / .55,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.green.shade100,
          highlightColor: Colors.green.shade50,
          child: Container(
            margin: const EdgeInsets.only(right: 12, top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: .5, color: yellowGreen),
            ),
            child: Column(
              children: [
                Container(
                  height: height * .14,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                kHight10,
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 50,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 6,  
                    ),
    );
  }
}
