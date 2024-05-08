import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/text_styles.dart';

class SectionHead extends StatelessWidget {
  const SectionHead({super.key, required this.heading});

  final String heading;
  @override
  Widget build(BuildContext context) {
    return Text(
      
      heading,
      style:semiBoldBlack,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
    );
  }
}