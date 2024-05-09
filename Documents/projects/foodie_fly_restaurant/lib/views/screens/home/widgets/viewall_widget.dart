import 'package:flutter/material.dart';

import '../../../../utils/text_styles.dart';

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

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: bigBoldBlack,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10)
          ),
          
          child: InkWell(
              onTap: onTap,
              child: Text(
                buttonName,
                style: regularGrey,
              )),
        ),
      ],
    );
  }
}
