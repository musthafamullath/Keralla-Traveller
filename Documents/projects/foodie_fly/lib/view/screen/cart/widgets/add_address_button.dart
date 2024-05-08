import 'package:flutter/material.dart';
import 'package:foodie_fly/view/screen/address/screen_address.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({
    super.key,
    required this.width,
    required this.couponCode, required this.height,
  });

  final double width;
  final String couponCode;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      width: width * 1.3,
      text: 'Add or select address',
      onPressed: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenAddresses(couponCode: couponCode),
          ),
        );
      }, height: height *1.2/10,
    );
  }
}
