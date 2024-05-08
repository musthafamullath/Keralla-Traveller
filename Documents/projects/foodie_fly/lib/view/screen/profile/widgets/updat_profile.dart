import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/model/profile.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_form_field.dart';

class ScreenUpdateProfile extends StatelessWidget {
  ScreenUpdateProfile({super.key, required this.profile});
  final Profile profile;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  initController() {
    nameController.text = profile.firstName;
    mobileController.text = profile.phone;
    emailController.text = profile.email;
  }

  @override
  Widget build(BuildContext context) {
    initController();
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBarWidget(title: 'Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kHight20,
              TextFieldWidget(
                userController: nameController,
                label: 'Name',
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
              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Mobile no'),
                  enabled: false,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              kHight10,
              TextFieldWidget(
                userController: emailController,
                label: 'E-mail',
                inputType: TextInputType.name,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the email';
                  }
                  return null;
                },
              ),
              kHight10,
              ButtonWidget(
                width: width,
                text: 'Update',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final profile = Profile(
                      userId: 0,
                      firstName: nameController.text,
                      lastName: '',
                      email: emailController.text,
                      phone: '',
                      status: '',
                    );
                    context.read<ProfileBloc>().add(UpdateUserProfileEvent(
                        profile: profile, context: context));
                  }
                }, height: width *2.5/10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
