import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

class AppTextFieldFour extends StatelessWidget {
  final String hint;

  const AppTextFieldFour({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
      enabledBorder: AppTextFieldBorders.border1,
      focusedBorder: AppTextFieldBorders.border1,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: AppColor.whiteOpacity,
    ));
  }
}
