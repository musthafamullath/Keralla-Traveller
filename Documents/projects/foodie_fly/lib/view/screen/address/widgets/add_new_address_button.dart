

import 'package:flutter/material.dart';
import 'package:foodie_fly/view/screen/add_address/screen_add_address.dart';
import 'package:foodie_fly/view/widgets/class_widgets/dotted_button.dart';

class AddNewAddressButton extends StatelessWidget {
  const AddNewAddressButton({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ScreenAddAddress(operation: Operation.add),
            ),
          );
        },
        child: DottedButtonWidget(
          width: width,
          height: height,
          title: 'Add New Address',
          icon: Icons.add,
        ),
      ),
    );
  }
}
