import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';

class SplashComponeses extends StatelessWidget {
  const SplashComponeses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            kHight100,
            kHight100,
            kHight100,
            kHight100,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: 'FOODIE ',
                    style: TextStyle(
                      fontSize: 50,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'FLY',
                    style: TextStyle(
                      backgroundColor: black,
                      decoration: TextDecoration.underline,
                      decorationColor: yellow,
                      decorationStyle: TextDecorationStyle.wavy,
                      fontSize: 50,
                      color: yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]))
              ],
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'RESTAURANT',
                    style: TextStyle(
                      fontSize: 25,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
