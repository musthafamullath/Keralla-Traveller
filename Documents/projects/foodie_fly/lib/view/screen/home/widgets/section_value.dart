import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/text_styles.dart';

class SectionValue extends StatelessWidget {
  const SectionValue({super.key, required this.heading});

  final String heading;
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: semiBoldGreen,
       textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
    );
  }
}