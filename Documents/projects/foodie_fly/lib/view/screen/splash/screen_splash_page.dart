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
    super.initState();
    checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: yellowGreen,
      body: SplashComponeses(),
    );
  }

  Future<void> checkUserLogin() async {
    final preferences = await SharedPreferences.getInstance();
    final userOnboarding = preferences.getBool('ON_BOARD') ?? false;
    final userLoggedIn = preferences.getBool('LOGIN') ?? false;
    await Future.delayed(const Duration(seconds: 3));

    if (!userOnboarding) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ScreenOnBoarding()),
        );
      }
    } else if (!userLoggedIn) {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ScreenLoginRestration(),
          ),
        );
      }
    } else {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenMainPage(),
          ),
        );
      }
    }
  }
}
