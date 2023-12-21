import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  final Color? iconColor;
  final Color? textcolor;

  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: iconColor ?? Colors.white,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            color: textcolor ?? const Color.fromARGB(255, 201, 200, 200),
          ),
        ),
      ),
    );
  }
}
