import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {super.key,
      required this.width,
      required this.text,
      required this.onPressed});

  final double width;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: yellowGreen,
          ),
        ),
      ),
    );
  }
}