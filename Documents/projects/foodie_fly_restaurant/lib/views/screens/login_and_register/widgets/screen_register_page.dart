import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/singup/signup_bloc.dart';
import 'package:foodie_fly_restaurant/models/restaurant.dart';
import 'package:foodie_fly_restaurant/views/screens/main/screen_main_page.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/toggle_password_function.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/toggle_repassword_function.dart';

import '../../../../controllers/cubits/toggle_password/toggle_password_cubit.dart';
import '../../../../controllers/cubits/toggle_repassword/toggle_repassword_cubit.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/text_form_field_validators.dart';
import '../../../widgets/class_widgets/button_widget.dart';
import '../../../widgets/class_widgets/demo_user.dart';
import '../../../widgets/class_widgets/text_field_widget.dart';
import '../../../widgets/function_widgets/snackbar_function.dart';

class ScreenRegisterPage extends StatefulWidget {
  const ScreenRegisterPage({super.key});

  @override
  State<ScreenRegisterPage> createState() => _ScreenRegisterPageState();
}

class _ScreenRegisterPageState extends State<ScreenRegisterPage> {
  final formKey = GlobalKey<FormState>();

  final restaurantNameController = TextEditingController();

  final descriptionController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final rePasswordController = TextEditingController();

  final pinCodeController = TextEditingController();

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
                // kHight10,
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign Up to your account",
                  style: TextStyle(fontSize: 18),
                ),
                // kHight10,
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      kHight10,
                      TextFieldWidget(
                        userController: restaurantNameController,
                        label: 'Restaurant name:',
                        inputType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your restaurant name';
                          }
                          return null;
                        },
                      ),
                      kHight10,
                      TextFieldWidget(
                        userController: descriptionController,
                        label: 'Description:',
                        inputType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your description';
                          }
                          return null;
                        },
                      ),
                      kHight10,
                      TextFieldWidget(
                        userController: emailController,
                        label: 'Email-address:',
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
                      TextFieldWidget(
                        userController: pinCodeController,
                        label: 'Pin Code:',
                        inputType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your pin code';
                          }
                          return null;
                        },
                      ),
                      kHight10,
                      BlocBuilder<TogglepasswordCubit, bool>(
                        builder: (context, state) {
                          return TextFieldWidget(
                            userController: passwordController,
                            label: 'Password:',
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
                            userController: rePasswordController,
                            label: 'Re-enter Password:',
                            inputType: TextInputType.emailAddress,
                            obscureText: state,
                            suffixIcon: toggleRePassword(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Re-enter password';
                              }
                              if (value != passwordController.text) {
                                return 'Wrong password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      kHight20,
                      BlocConsumer<SignupBloc, SignupState>(
                        listener: (context, state) {
                          if (state is SellerRegistrationSuccessState) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => ScreenMainPage(),
                            ));
                            showSnack(context, green, "successfully signed up");
                          } else if (state
                              is SellerRegistrationFailedInvalidfields) {
                            showSnack(context, amber, "failed. invalid fields");
                          } else if (state is SellerRegistrationFailedToLogin) {
                            showSnack(context, amber, "failed to Login");
                          } else if (state
                              is SellerRegistrationFieldToParseBodyState) {
                            showSnack(context, orange, "failed to parse body");
                          } else if (state is SellerRegistrationErrorState) {
                            showSnack(context, red, "Error");
                          }
                        },
                        builder: (context, state) {
                          return ButtonWidget(
                            width: size * 6 / 10,
                            height: size * 2.7 / 10,
                            text: 'Register',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final restaurantName =
                                    restaurantNameController.text;
                                final description = descriptionController.text;
                                final email = emailController.text;
                                final pinCode = pinCodeController.text;
                                final password = passwordController.text;
                                final rePassword = rePasswordController.text;
                                final restaurant = RestaurantRegisteration(
                                  confirmPassword: rePassword,
                                  description: description,
                                  email: email,
                                  name: restaurantName,
                                  password: password,
                                  pinCode: pinCode,
                                );
                                context.read<SignupBloc>().add(
                                    SellerSignupEvent(
                                        restaurantRegisteration: restaurant));
                              }
                            },
                          );
                        },
                      ),
                      kHight20,
                      const DemoUser(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
