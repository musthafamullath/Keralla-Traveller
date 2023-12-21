import 'package:flutter/material.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_imgesloginsignup.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldone.dart';
import 'package:keralatraveller/refacteredclasses/app_widgets.dart';
import 'package:keralatraveller/refacteredfunctions/app_regexsfunc.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/listofhome.dart';
import 'package:keralatraveller/screens/login_page.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppWidgets(
        mainwidget: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  AppSizedBoxes.box1,
                  const Text(
                    'Hello!, admin, your welcome',
                    style: Apptext.text2,
                  ),
                  AppSizedBoxes.box1,
                  const AppImageLoginSignup(),
                  AppSizedBoxes.box1,
                  AppTextFieldOne(
                    hint: "name",
                    keyboard: TextInputType.name,
                    controller: _nameController,
                    validator: validateName,
                  ),
                  AppSizedBoxes.box1,
                  AppTextFieldOne(
                    hint: "password",
                    keyboard: TextInputType.visiblePassword,
                    controller: _passwordController,
                    validator: validateLoginPassed,
                  ),
                  AppSizedBoxes.box1,
                  Appbutton(
                    bottonText: "sign in",
                    bottonnavigator: () {
                      if (_formkey.currentState!.validate()) {
                        if (_nameController.text.trim() == 'musthafa' &&
                            _passwordController.text.trim() == '123456') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ListOfHome(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'invalid username or password',
                              ),
                              backgroundColor: AppColor.red,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  AppSizedBoxes.box1,
                  Appbutton(
                      bottonText: "user?",
                      bottonnavigator: () {
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                            builder: (context) => const LogIn(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
