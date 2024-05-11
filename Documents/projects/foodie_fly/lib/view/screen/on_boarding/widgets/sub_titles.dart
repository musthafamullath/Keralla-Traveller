import 'package:flutter/material.dart';

class SubTitles extends StatelessWidget {
  SubTitles({super.key, required this.position});

  final int position;

  final subTitles = [
    "Embark on a culinary journey with our diverse food categories, from traditional to exotic. Indulge in tantalizing dishes designed to delight your taste buds, accompanied by exclusive offers. Discover surprises awaiting your exploration!",
    "Embark on a gastronomic adventure at our diverse restaurants. From cozy cafes to elegant eateries, each venue promises a unique ambiance and enticing menu. Discover memorable dining experiences that cater to every palate.",
    "Begin your food ordering journey now. Explore our menu and place your order hassle-free. Savor delicious dishes delivered right to your doorstep."
  ];

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitles[position],
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
