
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Text(
        text,
        style:const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
  }
}