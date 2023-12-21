import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';

// ignore: must_be_immutable
class AppAvatarUser extends StatelessWidget {
  final double size;
  final double width;
  final double height;
  Widget? imageWidget;
   AppAvatarUser({super.key, this.size = 40,this.imageWidget, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height:300,
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColor.black, style: BorderStyle.solid, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: imageWidget
      ),
    );
  }
}
