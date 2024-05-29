import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OfferShimmer extends StatelessWidget {
  final double height;
  final double width;

  const OfferShimmer({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      height: height * .38,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.green.shade100,
        highlightColor: Colors.green.shade50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: width - (width * .35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: height * .20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green.shade100,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                          width: 150,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 10,
                          width: 100,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 10,
                          width: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
