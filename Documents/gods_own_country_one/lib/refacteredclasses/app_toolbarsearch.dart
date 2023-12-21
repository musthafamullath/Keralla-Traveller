import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';

// ignore: must_be_immutable
class AppToolBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  TextStyle? textStyle;
  List<Widget>? action;
  Widget? drawer;
  PreferredSizeWidget? bottom;
  AppToolBar(
      {super.key, required this.title, this.action, this.bottom, this.drawer,this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: drawer,
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: textStyle,
        ),
        centerTitle: true,
        backgroundColor: AppColor.background,
        actions: action,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
