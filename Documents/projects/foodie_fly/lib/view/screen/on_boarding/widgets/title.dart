import 'package:flutter/material.dart';

class Titles extends StatelessWidget {
  Titles({super.key, required this.position});

  final int position;
  final titles = [
    "Explore a Diverse Selection of Food Categories, Dishes, Offers & More!",
    "Discover Our Restaurants",
    'Get started on Ordering your Foods'
  ];

  @override
  Widget build(BuildContext context) {
    return Text(
      titles[position],
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}