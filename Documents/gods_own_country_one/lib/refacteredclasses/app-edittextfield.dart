// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';

class AppTextFieldOne1 extends StatelessWidget {
  final String hint;
  final TextInputType keyboard;
  final TextEditingController controller;
  final String errormessage;
  final int minLiness;
  final int maxLiness;

  const AppTextFieldOne1({
    super.key,
    required this.hint,
    required this.keyboard,
    required this.controller,
    required this.minLiness,
    required this.maxLiness, 
    required this.errormessage,
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
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: AppColor.whiteOpacity,
      ),
      validator: (value){
        if(value!.isEmpty){
          return errormessage;
        }else{
          return null;
        }
      },
    );
  }
}

String? validateNotEmpty(String value) {
  if (value.isEmpty) {
    return AppStrings.pleaseenteravalue;
  }
  return null;
}
