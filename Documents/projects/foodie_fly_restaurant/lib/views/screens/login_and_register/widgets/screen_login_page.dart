import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/login/login_bloc.dart';
import 'package:foodie_fly_restaurant/views/screens/main/screen_main_page.dart';
import 'package:foodie_fly_restaurant/views/widgets/class_widgets/demo_user.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/toggle_password_function.dart';

import '../../../../controllers/cubits/toggle_password/toggle_password_cubit.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_form_field_validators.dart';
import '../../../widgets/class_widgets/button_widget.dart';
import '../../../widgets/class_widgets/text_field_widget.dart';
import '../../../widgets/function_widgets/snackbar_function.dart';

class ScreenLoginPage extends StatefulWidget {
  const ScreenLoginPage({super.key});

  @override
  State<ScreenLoginPage> createState() => _ScreenLoginPageState();
}

class _ScreenLoginPageState extends State<ScreenLoginPage> {
  final formKey = GlobalKey<FormState>();

  final userController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(15),
          shadowColor: grey,
          surfaceTintColor: grey,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: grey.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                kHight30,
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Login to your account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                kHight30,
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFieldWidget(
                        userController: userController,
                        label: 'Email-address:',
                        inputType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          const pattern = regexPatternForLoginAndSignUpByEmail;
                          final regex = RegExp(pattern);
                          return value!.isEmpty || !regex.hasMatch(value)
                              ? "Enter a valid Email Address"
                              : null;
                        },
                      ),
                      kHight10,
                      BlocBuilder<TogglepasswordCubit, bool>(
                        builder: (context, state) {
                          return TextFieldWidget(
                            userController: passwordController,
                            label: 'Password:',
                            inputType: TextInputType.name,
                            obscureText: state,
                            suffixIcon: togglePassword(),
                            validator: (value) {
                              const pattern =
                                  regexPatternForLoginAndSignUpByPassword;
                              final regex = RegExp(pattern);
                              if (value!.isEmpty) {
                                return "Please Enter password";
                              } else {
                                if (!regex.hasMatch(value)) {
                                  return "Enter Valid Password";
                                } else {
                                  return null;
                                }
                              }
                            },
                          );
                        },
                      ),
                      kHight30,
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is SellerLoginSuccessState) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => ScreenMainPage(),
                            ));
                            showSnack(context, green, "successfully signed up");
                          } else if (state is SellerLoginFailedInvalidFields) {
                            showSnack(context, amber, "failed invalid fields");
                          } else if (state is SellerLoginFailedToLogin) {
                            showSnack(context, amber, "failed to register");
                          } else if (state
                              is SellerLoginFieldToParseBodyState) {
                            showSnack(context, orange, "failed to parse body");
                          } else if (state is SellerLoginErrorState) {
                            showSnack(context, red, "Error");
                          }
                        },
                        builder: (context, state) {
                          return ButtonWidget(
                            width: size * 6 / 10,
                            text: 'Login',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final email = userController.text;
                                final password = passwordController.text;
                                context.read<LoginBloc>().add(SellerLoginEvent(
                                    email: email, password: password));
                              }
                            },
                            height: size * 2.7 / 10,
                          );
                        },
                      ),
                      kHight50,
                      const DemoUser(),
                    ],
                  ),
                ),
                kHight30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
