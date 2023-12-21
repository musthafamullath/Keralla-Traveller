
import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_images.dart';

class AppImageLoginSignup extends StatelessWidget {
  const AppImageLoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          AppImages.logimage,
          fit: BoxFit.cover,
        ));
  }
}
