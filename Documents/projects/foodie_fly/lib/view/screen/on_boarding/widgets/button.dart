// ignore_for_file: unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/view/screen/signup_login/screen_login_and_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.width, required this.position});

  final double width;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width * .5,
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: ElevatedButton(
              onPressed: () async {
                if(position == 2){
                  await _completeOnboarding(context);
                }else{
                  await _skipOnboarding(context);
                }
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => const ScreenLoginRestration() ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(position == 2 ? "Let's Start" : 'Skip',style: semiBoldWhite,),
            ),
          ),
        ),
      ],
    );
  }
    Future<void> _completeOnboarding(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ON_BOARD', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ScreenLoginRestration()),
    );
  }

  Future<void> _skipOnboarding(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('ON_BOARD', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const ScreenLoginRestration()),
    );
  }
}
