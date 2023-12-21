import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';

class AppBoxdecoration {
  static final decoration1 = BoxDecoration(
    color: AppColor.buttoncolor,
    border:
        Border.all(color: AppColor.black, style: BorderStyle.solid, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(25)),
  );
  static final decoration2 =  BoxDecoration(
    color: AppColor.whiteOpacity2,
    shape: BoxShape.circle,
  );
  static final decoration3 = BoxDecoration(
    color: AppColor.whiteOpacity1,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    border:
        Border.all(color: AppColor.black, style: BorderStyle.solid, width: .7),
  );
}
