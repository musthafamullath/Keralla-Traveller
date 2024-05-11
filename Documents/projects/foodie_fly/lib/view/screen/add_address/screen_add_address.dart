import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/address/address_bloc.dart';
import 'package:foodie_fly/model/address.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_form_field.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';

enum Operation { add, edit }

class ScreenAddAddress extends StatefulWidget {
   const ScreenAddAddress({super.key, required this.operation, this.address});
   final Operation operation;
   final Address? address;

  @override
  State<ScreenAddAddress> createState() => _ScreenAddAddressState();
}

class _ScreenAddAddressState extends State<ScreenAddAddress> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final houseNameController = TextEditingController();
  final streetController = TextEditingController();
  final pinodeController = TextEditingController();
  final mobileController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  initControllers() {
    if (widget.address != null) {
      nameController.text = widget.address!.name;
      houseNameController.text = widget.address!.houseName;
      streetController.text = widget.address!.street;
      pinodeController.text = widget.address!.pinCode;
      mobileController.text = widget.address!.phone;
      districtController.text = widget.address!.district;
    }
  }

  @override
  void initState() {
    if (widget.operation == Operation.edit) {
      initControllers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBarWidget(
          title: widget.operation == Operation.add
              ? 'Add New Address'
              : 'Update Address',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  userController: nameController,
                  label: 'Name:',
                  hintText: ' eg : musthafa',
                  inputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the name';
                    }
                    return null;
                  },
                ),
                kHight10,
                TextFieldWidget(
                  userController: houseNameController,
                  label: 'House Name:',
                  hintText: ' eg : mullath',
                  inputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the house name';
                    }
                    return null;
                  },
                ),
                kHight10,
                TextFieldWidget(
                  userController: streetController,
                  label: 'Street:',
                  hintText: ' eg : kalad',
                  inputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the street name';
                    }
                    return null;
                  },
                ),
                kHight10,
                TextFieldWidget(
                  userController: pinodeController,
                  label: 'Pin code:',
                  hintText: ' eg : 676109',
                  inputType: TextInputType.number,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Pin code';
                    }
                    return null;
                  },
                ),
                kHight10,
                TextFieldWidget(
                  userController: mobileController,
                  label: 'Mobile Number:',
                  hintText: ' type with coundry code ( eg: +91 )',
                  inputType: TextInputType.text,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Mobile Number';
                    }
                    return null;
                  },
                ),
                 kHight10,
                TextFieldWidget(
                  userController: stateController,
                  label: 'State:',
                  hintText: ' eg : kerala',
                  inputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the State name';
                    }
                    return null;
                  },
                ),
                kHight10,
                TextFieldWidget(
                  userController: districtController,
                  label: 'District:',
                  hintText: ' eg : malappuram',
                  inputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the district name';
                    }
                    return null;
                  },
                ),
                kHight20,
                ButtonWidget(
                  width: width,
                  text: widget.operation == Operation.add ? 'Submit' : 'Update',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final addresss = Address(
                        addressId: widget.operation == Operation.add
                            ? 0
                            : widget.address!.addressId,
                        userId: 0,
                        district: districtController.text,
                        houseName: houseNameController.text,
                        name: nameController.text,
                        phone: mobileController.text,
                        pinCode: pinodeController.text,
                        street: streetController.text, 
                        state: stateController.text,
                      );
                      if (widget.operation == Operation.add) {
                        context.read<AddressBloc>().add(AddAddressEvent(
                            address: addresss, context: context));
                            Navigator.of(context).pop();
                            showSnack(context, kGreen, "New Address added");
                      } else {
                        context.read<AddressBloc>().add(UpdateAddressEvent(
                            address: addresss, context: context));
                            showSnack(context, kGreen, "New Address not added");
                            Navigator.of(context).pop();
                      }
                    }
                  }, height: height *1/10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
