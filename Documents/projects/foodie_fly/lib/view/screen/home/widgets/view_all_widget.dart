import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';

class ViewAllwidget extends StatelessWidget {
  const ViewAllwidget({
    super.key,
    required this.text,
    required this.buttonName,
    required this.onTap,
  });
  final String text;
  final String buttonName;
  final Function()? onTap;

  get semiBoldOrange => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: black),
        ),
        InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade50),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  buttonName,
                  style: regularBlack,
                ),
              ),
            )),
      ],
    );
  }
}
