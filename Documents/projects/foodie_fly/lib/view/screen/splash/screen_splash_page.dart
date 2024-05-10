// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/screen/on_boarding/screen_splash.dart';
import 'package:foodie_fly/view/screen/signup_login/screen_login_and_signup.dart';
import 'package:foodie_fly/view/screen/splash/widgets/splash_componense.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // checkUserOnBoarding();
    checkUserLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: yellowGreen,
      body:  SplashComponeses(),
    );
  }

  Future<void> checkUserLogin(context) async {
    final preferences = await SharedPreferences.getInstance();
    final userBoardaring = preferences.getBool('ON_BORD');
    final userLoggedIn = preferences.getBool('LOGIN');
    if(userBoardaring == null || userBoardaring == false){
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScreenOnBoarding(),)
      );
    }
    else if (userLoggedIn == null || userLoggedIn == false) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ScreenLoginRestration(),
        ),
      );
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenMainPage(),
        ),
      );
    }
  }
}
