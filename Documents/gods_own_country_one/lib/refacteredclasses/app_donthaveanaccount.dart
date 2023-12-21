import 'package:flutter/material.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screens/signup_page.dart';

class AppDonthaveAnAccount extends StatelessWidget {
  const AppDonthaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppStrings.dontHaveAnAccount,
          style: Apptext.text3,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp(),));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text(
              AppStrings.signUp,
              style: Apptext.text6,
            )),
      ],
    );
  }
}
