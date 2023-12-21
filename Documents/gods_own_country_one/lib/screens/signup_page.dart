import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_imgesloginsignup.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldone.dart';
import 'package:keralatraveller/refacteredfunctions/app_regexsfunc.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/refacteredclasses/app_widgets.dart';
import 'package:keralatraveller/screens/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: AppWidgets(
        mainwidget: Form(
          key: _formkey,
          child: Column(
            children: [
              AppSizedBoxes.box3,
              const Text(
                AppStrings.createanaccount,
                style: Apptext.text11,
              ),
              AppSizedBoxes.box3,
              const AppImageLoginSignup(),
              AppSizedBoxes.box3,
              AppTextFieldOne(
                  hint: AppStrings.userName,
                  validators: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  controller: _nameController,
                  validator: validateUsername),
              AppSizedBoxes.box5,
              AppTextFieldOne(
                  hint: AppStrings.email,
                  validators: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: validateEmail),
              AppSizedBoxes.box5,
              AppTextFieldOne(
                  hint: AppStrings.passWord,
                  validators: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: validatePassword),
              AppSizedBoxes.box3,
              Appbutton(
                bottonText: AppStrings.signUp,
                bottonnavigator: () async {
                  if (_formkey.currentState!.validate()) {
                   await signUpAndAddDetailsToBD(
                      Mycountry(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    await snakBarAndNavigatorFromAddDB(context);
                  }
                },
              ),
              AppSizedBoxes.box3,
              Appbutton(bottonText: "Go Back To Sign In", bottonnavigator: (){
                Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const LogIn(),));
              }),
              AppSizedBoxes.box3,
            ],
          ),
        ),
      ),
    );
  }
}
