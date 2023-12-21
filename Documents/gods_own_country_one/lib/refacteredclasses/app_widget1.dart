import 'package:flutter/material.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

class AppWidgetsOne extends StatelessWidget {
  final Widget mainwidget;
  const AppWidgetsOne({super.key, required this.mainwidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: BackgroundWrapper(
            child: SingleChildScrollView(
                  child: Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 30, right: 30),
            decoration: AppTextFieldBorders.border3,
            child: mainwidget,
                  ),
                ),
          ),
    );
  }
}