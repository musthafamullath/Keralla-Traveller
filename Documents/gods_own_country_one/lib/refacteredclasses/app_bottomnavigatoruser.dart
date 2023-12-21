import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_boxdecoration.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/screens/head_page_user.dart';

class AppbottomnavigatorsUser extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Menususer iconClick;
  final Menususer name;
  const AppbottomnavigatorsUser(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.iconClick,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      decoration: AppBoxdecoration.decoration2,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: iconClick == name ? AppColor.buttoncolor : AppColor.white,
      ),
    );
  }
}
