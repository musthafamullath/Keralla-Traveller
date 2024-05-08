// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';

class ScreenIndicator extends StatelessWidget {
  int position;
  ScreenIndicator({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Row(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor:
                  index == position ? Colors.green[800] : Colors.grey,
            ),
            kWidth10
          ],
        );
      }),
    );
  }
}