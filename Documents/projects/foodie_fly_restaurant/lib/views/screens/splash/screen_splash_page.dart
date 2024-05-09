import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/login_and_register/screen_login_and_registeration.dart';
import 'package:foodie_fly_restaurant/views/screens/main/screen_main_page.dart';
import 'package:foodie_fly_restaurant/views/screens/splash/widget/splash_componeses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    checkUserLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: yellow,
      body: SplashComponeses(),
    );
  }
  
  Future<void> checkUserLogin(context) async {
    final preferences = await SharedPreferences.getInstance();
    final userLoggedIn = preferences.get('LOGIN');
    if (userLoggedIn == null || userLoggedIn == false) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ScreenLoginRestration(),
      ));
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScreenMainPage(),
      ));
    }
  }
}


