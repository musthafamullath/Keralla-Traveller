import 'package:flutter/material.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

class AppWidgets extends StatelessWidget {
  final Widget mainwidget;
  const AppWidgets({super.key, required this.mainwidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWrapper(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 90,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 10, right: 10,bottom: 30),
              decoration: AppTextFieldBorders.border3,
              child: mainwidget,
            ),
          ),
        ),
      ),
    );
  }
}
