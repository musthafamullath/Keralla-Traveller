import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/main.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refacteredclasses/app_button.dart';
import 'package:keralatraveller/refacteredclasses/app_donthaveanaccount.dart';
import 'package:keralatraveller/refacteredclasses/app_imgesloginsignup.dart';
import 'package:keralatraveller/refacteredclasses/app_textfieldone.dart';
import 'package:keralatraveller/refacteredfunctions/app_regexsfunc.dart';
import 'package:keralatraveller/refactoredwidgets/app_sizedboxes.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/refacteredclasses/app_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keralatraveller/screens/adminloginscreen.dart';
import 'package:keralatraveller/screens/head_page_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late Box mycountryBox;
  @override
  void initState() {
    mycountryBox = Hive.box("mycountry");
    super.initState();
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isIdxMatched = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusNode currentfocus = FocusScope.of(context);
        if (!currentfocus.hasPrimaryFocus) {
          currentfocus.unfocus();
        }
      },
      child: ValueListenableBuilder(
        valueListenable: mycountryBox.listenable(),
        builder: (context, value, child) => AppWidgets(
          mainwidget: Form(
            key: _formkey,
            child: Column(
              children: [
                AppSizedBoxes.box3,
                const Text(
                  AppStrings.helloWelcome,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  textScaleFactor: 1.1,
                  style: Apptext.text1,
                ),
                AppSizedBoxes.box3,
                const AppImageLoginSignup(),
                AppSizedBoxes.box3,
                const Text(
                  AppStrings.toContinue,
                  style: Apptext.text2,
                ),
                AppSizedBoxes.box5,
                AppTextFieldOne(
                  hint: AppStrings.email,
                  keyboard: TextInputType.text,
                  controller: _emailController,
                  validator: validateEmail,
                  validators: AutovalidateMode.disabled,
                ),
                AppSizedBoxes.box5,
                AppTextFieldOne(
                  hint: AppStrings.passWord,
                  keyboard: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: validateLoginPassed,
                  validators: AutovalidateMode.disabled,
                ),
                AppSizedBoxes.box5,
                Appbutton(
                  bottonText: AppStrings.signIn,
                  bottonnavigator: logincheck,
                ),
                AppSizedBoxes.box5,
                const AppDonthaveAnAccount(),
                AppSizedBoxes.box5,
                Appbutton(
                    bottonText: "admin?",
                    bottonnavigator: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AdminLoginScreen(),
                      ));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logincheck() async {
    bool isUser = false;

    var signInData = mycountryBox.values.cast<Mycountry>().toList();

    String enteredUserName = _emailController.text.trim();
    String enteredPassWord = _passwordController.text.trim();

    bool codeMatched = signInData.any((element) =>
        element.email == enteredUserName &&
        element.password == enteredPassWord);
    if (!codeMatched) {
      // ignore: use_build_context_synchronously
      loginSnackBarfeiledWithOutValue(context);
      return;
    }

    // User found with valid credentials
    isUser = true;

    // Find matching user index in Hive box
    for (int i = 0; i < mycountryBox.length; i++) {
      final storedUserValue = mycountryBox.getAt(i);
      if (_emailController.text.trim() == storedUserValue?.email &&
          _passwordController.text.trim() == storedUserValue?.password){
         _indexinSharedpref(i); // Store user index for future use
        break; // User found, stop looping
      }
    }

    // ignore: dead_code
    if (!isUser) {
      // ignore: use_build_context_synchronously
      loginSnackBarfeiledWithOutValue(context);
      return;
    }

    // User login successful
    final sheredprifer = await SharedPreferences.getInstance();
    await sheredprifer.setBool(SAVE_KEY_NAME, true);
    await sheredprifer.setBool(
        USER_ROLE_KEY, false); // User role is regular user
    // ignore: use_build_context_synchronously
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => const HeadPageUser()),
        (route) => false);
    _passwordController.clear();
    _emailController.clear();
  }

  Future<void> _indexinSharedpref(int index) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    await sharedpref.setInt('userIndex', index);
  }
}
