import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/text_styles.dart';

class SectionHead extends StatelessWidget {
  const SectionHead({super.key, required this.heading, required this.values});

  final String heading;
  final String values;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: heading,style: semiBoldBlack),
          TextSpan(text: values ,style: semiBoldGrey,),
        ]
      )
    );
  }
}