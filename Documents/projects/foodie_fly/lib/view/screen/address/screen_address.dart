import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/address/address_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/add_address/screen_add_address.dart';
import 'package:foodie_fly/view/screen/address/widgets/add_new_address_button.dart';
import 'package:foodie_fly/view/screen/address/widgets/confirmation_button.dart';
import 'package:foodie_fly/view/screen/home/widgets/section_head.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';

class ScreenAddresses extends StatefulWidget {
  const ScreenAddresses({super.key, this.couponCode});
  final String? couponCode;

  @override
  State<ScreenAddresses> createState() => _ScreenAddressesState();
}

class _ScreenAddressesState extends State<ScreenAddresses> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<AddressBloc>().add(GetAllAddressEvent());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarWidget(title: 'Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<AddressBloc>()
                              .add(SelectAddressEvent(index: index));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          width: width,
                          decoration: BoxDecoration(
                            color: state.index == index
                                ? Colors.grey.shade300
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade400 ,width: 2),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: black.withOpacity(0.1),
                                        child: const Icon(
                                            Icons.location_on_outlined,
                                            size: 24,
                                            color: Colors.red),
                                      ),
                                      kWidth10,
                                      SectionHead(
                                          heading: state.addresses[index].name),
                                    ],
                                  ),
                                  ButtonWidget(
                                    width: width * 6 / 10,
                                    text: 'Change',
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ScreenAddAddress(
                                            operation: Operation.edit,
                                            address: state.addresses[index],
                                          ),
                                        ),
                                      );
                                    },
                                    height: width * 2 / 10,
                                  )
                                ],
                              ),
                              kHight10,
                              Text(
                                '${state.addresses[index].houseName}, ${state.addresses[index].street}, ${state.addresses[index].pinCode}, ${state.addresses[index].district}, ${state.addresses[index].state}, ${state.addresses[index].phone}',
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.addresses.length,
                  );
                },
              ),
              kHight10,
              AddNewAddressButton(width: width, height: height),
              kHight30,
              ConfirmationButton(
                width: width,
                couponCode: widget.couponCode,
                height: height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
