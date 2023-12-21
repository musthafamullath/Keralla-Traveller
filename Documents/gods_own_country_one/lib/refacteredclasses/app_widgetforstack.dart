import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

class AppWidgetsForStack extends StatelessWidget {
  final Widget mainwidget;
  const AppWidgetsForStack({super.key, required this.mainwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTextFieldBorders.border4,
      child: mainwidget,
    );
  }
}
