import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class ProfileSpanText extends StatelessWidget {
  final String indicateText;
  final String valueText;
  const ProfileSpanText({
    super.key,
    required this.indicateText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: indicateText, style: semiBoldBlack),
        TextSpan(text: valueText, style: semiBoldGrey)
      ]),
    );
  }
}