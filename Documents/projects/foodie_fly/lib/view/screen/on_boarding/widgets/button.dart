import 'package:flutter/material.dart';
import 'package:foodie_fly/view/screen/signup_login/screen_login_and_signup.dart';

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
          width: width * .3,
          child: ElevatedButton(
            onPressed: () async {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ScreenLoginRestration() ));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(position == 2 ? "Let's Start" : 'Skip'),
          ),
        ),
      ],
    );
  }
}
