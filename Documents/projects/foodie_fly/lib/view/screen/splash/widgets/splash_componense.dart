import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie_fly/utils/constants.dart';


class SplashComponeses extends StatefulWidget {
  const SplashComponeses({
    super.key,
  });

  @override
  State<SplashComponeses> createState() => _SplashComponesesState();
}

class _SplashComponesesState extends State<SplashComponeses> {
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
                    text: 'FORK ',
                    style: TextStyle(
                      fontSize: 50,
                      color: white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'PLATE',
                    style: TextStyle(
                      backgroundColor: white,
                      decoration: TextDecoration.underline,
                      decorationColor: yellowGreen,
                      decorationStyle: TextDecorationStyle.wavy,
                      fontSize: 50,
                      color: yellowGreen,
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
                    text: 'Client',
                    style: TextStyle(
                      fontSize: 25,
                      color: white,
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
