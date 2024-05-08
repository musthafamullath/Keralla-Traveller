import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/text_styles.dart';

class StringGenarator extends StatelessWidget {
  const StringGenarator({super.key, required this.string});
  final String string;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(string,style: semiBoldBlack,),
          ),
        ),
      ),
    );
  }
}