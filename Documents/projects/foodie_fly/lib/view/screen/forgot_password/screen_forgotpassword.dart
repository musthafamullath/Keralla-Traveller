import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_password/toggle_password_cubit.dart';
import 'package:foodie_fly/controller/cubits/toggle_repasswod/toggle_repassword_cubit.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/utils/validaters.dart';
import 'package:foodie_fly/view/widgets/class_widgets/app_bar_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_form_field.dart';
import 'package:foodie_fly/view/widgets/function_widgets/toggle_password.dart';
import 'package:foodie_fly/view/widgets/function_widgets/toggle_repassword.dart';

class ScreenForgotPassword extends StatefulWidget {
  const ScreenForgotPassword({super.key});

  @override
  State<ScreenForgotPassword> createState() => _ScreenForgotPasswordState();
}

class _ScreenForgotPasswordState extends State<ScreenForgotPassword> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final renewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBarWidget(title: "Forgot Password")),
      body: SafeArea(
        child: Container(
          height: width*10/10,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey.shade300),
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: [
                  const Text(
                    'Forgot password',
                    style: bigBoldBlack,
                  ),
                  kHight10,
                  const Text(
                    'Enter your E-mail id: & Password',
                    style: regularGrey,
                  ),
                  kHight10,
                  TextFieldWidget(
                    userController: emailController,
                    label: 'E-mail id:',
                    inputType: TextInputType.emailAddress,
                    obscureText: false,
                    validator: (value) {
                      const pattern = regexPatternForLoginAndSignUpByEmail;
                      final regex = RegExp(pattern);
                      if (value!.isEmpty || !regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  kHight10,
                  BlocBuilder<TogglepasswordCubit, bool>(
                    builder: (context, state) {
                      return TextFieldWidget(
                        userController: newPasswordController,
                        label: 'password:',
                        inputType: TextInputType.emailAddress,
                        obscureText: state,
                        suffixIcon: togglePassword(),
                        validator: (value) {
                          const pattern =
                              regexPatternForLoginAndSignUpByPassword;
                          final regex = RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          if (!regex.hasMatch(value)) {
                            return 'Enter valid password';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  kHight10,
                  BlocBuilder<ToggleRepasswordCubit, bool>(
                    builder: (context, state) {
                      return TextFieldWidget(
                        userController: renewPasswordController,
                        label: 'Re-enter Password:',
                        inputType: TextInputType.emailAddress,
                        obscureText: state,
                        suffixIcon: toggleRePassword(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Re-enter password';
                          }
                          if (value != newPasswordController.text) {
                            return 'Wrong password';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  kHight10,
                  Container(
                    alignment: Alignment.center,
                    child: ButtonWidget(
                      width: width,
                      height: width * 2.5 / 10,
                      text: 'Send',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
