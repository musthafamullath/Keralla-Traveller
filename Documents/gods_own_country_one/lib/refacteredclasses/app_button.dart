import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';

class Appbutton extends StatelessWidget {
  final String bottonText;
  final void Function() bottonnavigator;

  const Appbutton({super.key, required this.bottonText, required this.bottonnavigator});

 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: bottonnavigator,
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                    color: AppColor.black, style: BorderStyle.solid, width: 0.1),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              backgroundColor: AppColor.buttoncolor,
              foregroundColor: AppColor.white),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              bottonText,
              style: Apptext.text2,
            ),
          )),
    );
  }
}
