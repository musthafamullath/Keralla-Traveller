import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/login/login_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_password/toggle_password_cubit.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/validaters.dart';
import 'package:foodie_fly/view/screen/forgot_password/screen_forgotpassword.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/demo_user.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_btn_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_form_field.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';
import 'package:foodie_fly/view/widgets/function_widgets/toggle_password.dart';

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
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
            border: Border.all(width: 2,color: Colors.grey.shade200),
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Login to your account",
                style: TextStyle(fontSize: 18),
              ),
              kHight10,
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
                   
                      TextButtonWidget(
                  width: size,
                  text: 'Forgot password?',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScreenForgotPassword(),
                      ),
                    );
                  },
                ),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is SellerLoginSuccessState) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => ScreenMainPage(),
                          ));
                          showSnack(context, kGreen,
                              "successfully signed up");
                        } else if (state is SellerLoginFailedInvalidFields) {
                          showSnack(context, amber,
                              "failed invalid fields");
                        } else if (state is SellerLoginFailedToLogin) {
                          showSnack(context, amber,
                              "failed to register");
                        } else if (state
                            is SellerLoginFieldToParseBodyState) {
                          showSnack(
                              context, orange, "failed to parse body");
                        } else if (state is SellerLoginErrorState) {
                          showSnack(context,red, "Error");
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
                    kHight10,
                    const DemoUser(),
                  ],
                ),
              ),
              kHight10,
            ],
          ),
        ),
      ),
    );
  }
}
