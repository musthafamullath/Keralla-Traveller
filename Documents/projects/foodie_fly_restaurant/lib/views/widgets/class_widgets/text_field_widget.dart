import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.validator,
    this.userController,
    this.label,
    this.inputType,
    this.obscureText,
    this.suffixIcon,
    this.hinttext,
  });
  final TextEditingController? userController;
  final String? label;
  final TextInputType? inputType;
  final bool? obscureText;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final String? hinttext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        controller: userController,
        obscureText: obscureText!,
        keyboardType: inputType,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          
          hintText: hinttext,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          
          border: InputBorder.none
        ),
      ),
    );
  }
}
