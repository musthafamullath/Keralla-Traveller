import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';

class AstpetButton extends StatelessWidget {
  final String iconText;
  final Icon icons;
  final void Function() aspetfunction;
  const AstpetButton({super.key, required this.iconText, required this.icons, required this.aspetfunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      width: 110,
      decoration: BoxDecoration(
          color: AppColor.whiteOpacity1,
          border: Border.all(
              color: AppColor.black, style: BorderStyle.solid, width: 0.1),
          borderRadius: BorderRadius.circular(40)),
      child: TextButton.icon(
        onPressed: aspetfunction,
        icon: icons,
        label: Text(
          iconText,
          style: Apptext.text5,
        ),
      ),
    );
  }
  
}
