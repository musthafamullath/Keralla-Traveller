import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/address/address_bloc.dart';
import 'package:foodie_fly/view/screen/checkout/screen_check_out.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';

class ConfirmationButton extends StatelessWidget {
  const ConfirmationButton({
    super.key,
    required this.width,
    required this.couponCode, required this.height,
  });

  final double width;
  final String? couponCode;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        return ButtonWidget(
          width: width * 1.2,
          text: 'Confirm Location',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenCheckout(
                    couponCode: couponCode!,
                    addressId: state.addresses[state.index!].addressId),
              ),
            );
          }, height: height *1/10,
        );
      },
    );
  }
}
