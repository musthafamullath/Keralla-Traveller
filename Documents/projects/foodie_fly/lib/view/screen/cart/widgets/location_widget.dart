import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/cart/widgets/add_address_button.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';

class Locationwidget extends StatelessWidget {
  const Locationwidget({
    super.key,
    required this.width,
    required this.height,
    required this.couponCode,
  });

  final double width;
  final double height;
  final String couponCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * .25,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade50,
        border: Border.all(width: 2,color: Colors.grey.shade300)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor:
                    black.withOpacity(0.09),
                foregroundColor: red,
                child: const Icon(
                  Icons.location_on,
                  size: 30,
                ),
              ),
              const SectionHead(
                  heading:
                      'Where would you like \n us to deliver\n this order?')
            ],
          ),
          kHight30,
          AddAddressButton(
            width: width,
            couponCode: couponCode,
            height: height,
          )
        ],
      ),
    );
  }
}
