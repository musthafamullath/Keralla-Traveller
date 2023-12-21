import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldone.dart';
import 'package:keralatraveller/refacteredfunctions/app_regexsfunc.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/screenforadmin/listofhome.dart';
import 'package:keralatraveller/screens/login_page.dart';

class AdminloginScreen extends StatelessWidget {
  AdminloginScreen({super.key,});
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 40, right: 40, top: 120, bottom: 120),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.buttoncolor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
              bottomLeft: Radius.circular(50)),
            border: Border.all(width: 2, color: AppColor.black)),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .50,
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      
                      AppTextFieldOne(
                        controller: _emailController,
                        validator: validateName,
                        hint: 'name',
                        keyboard: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                     
                      AppTextFieldOne(
                        controller: _passwordController,
                        validator: validatePassword,
                        hint: 'password',
                        keyboard: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Appbutton(
                            bottonText: AppStrings.signIn,
                            bottonnavigator: () {
                              if (_formkey.currentState!.validate()) {
                                if (_emailController.text == 'musthafa' &&
                                    _passwordController.text == '123456') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ListOfHome(),
                                  ));
                                } else {
                                  loginSnackBarfeiledWithOutValue(context);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Are you user ?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LogIn(),
                                ),
                              );
                            },
                            child:const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color.fromARGB(255, 29, 236, 36),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
