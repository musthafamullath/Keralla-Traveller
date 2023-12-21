import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

// ignore: must_be_immutable
class AppTextFieldthree extends StatelessWidget {
  final String hint;
  final TextInputType keyboard;
  final TextEditingController controller;
  final Function(String) onChanged;
  int? minLiness;
  int? maxLiness;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  AppTextFieldthree({
    super.key,
    required this.hint,
    required this.keyboard,
    required this.controller,
    required this.onChanged,
    this.minLiness,
    this.maxLiness,
    this.hintStyle,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboard,
      minLines: minLiness,
      maxLines: maxLiness,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: AppTextFieldBorders.border1,
        focusedBorder: AppTextFieldBorders.border1,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        filled: true,
        fillColor: AppColor.whiteOpacity,
      ),
      onChanged: onChanged,
    );
  }
}
