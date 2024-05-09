import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';

import '../../../utils/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.width,
    required this.text,
    required this.onPressed,
    required this.height,
  });
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * .5,
      height: height * .4,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: yellow,
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        ),
        child: Text(text,style: semiBoldBlack,),
      ),
    );
  }
}
