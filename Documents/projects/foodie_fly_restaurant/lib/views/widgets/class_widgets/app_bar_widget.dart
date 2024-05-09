import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0.5, 0.5),
            )
          ],
          color: yellow,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35))),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 26,
                color: black,
              )),
        ),
      ),
    );
  }
}
