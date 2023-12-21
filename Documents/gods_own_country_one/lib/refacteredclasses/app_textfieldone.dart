import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

// ignore: must_be_immutable
class AppTextFieldOne extends StatelessWidget {
  AutovalidateMode? validators;
  final String hint;
  final TextInputType keyboard;
  final TextEditingController controller;
  final String? Function(String?) validator;
  int? minLiness;
  int? maxLiness;
  TextStyle? hintStyle;
  Widget? prefixIcon;
  AppTextFieldOne({
    super.key,
    required this.hint,
    required this.keyboard,
    required this.controller,
    required this.validator,
    this.minLiness,
    this.maxLiness,
    this.hintStyle,
    this.prefixIcon,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode:validators,
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: AppColor.whiteOpacity,
      ),
      validator: validator,
    );
  }
}
