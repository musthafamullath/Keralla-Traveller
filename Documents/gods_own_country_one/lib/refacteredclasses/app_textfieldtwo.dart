import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_textfeildborders.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';

class AppTextFieldTwo extends StatelessWidget {
  final String textone;
  final String textTwo;
  const AppTextFieldTwo(
      {super.key, required this.textone, required this.textTwo});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: AppTextFieldBorders.border2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              textone,
              width: 22,
              height: 22,
            ),
            AppSizedBoxes.box4,
            Text(
              textTwo,
              style: Apptext.text5,
            ),
          ],
        ));
  }
}
