import 'package:flutter/material.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_value.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({super.key, required this.keyString, required this.value,  this.width,  this.thickness,  this.color});

  final String keyString;
  final String value;
  final double? width;
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [SectionHead(heading: keyString), VerticalDivider(width: width,color:color,thickness: thickness,), SectionValue(heading: value)],
      ),
    );
  }
}