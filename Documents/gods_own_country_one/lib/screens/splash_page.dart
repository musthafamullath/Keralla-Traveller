import 'package:flutter/material.dart';
import 'package:keralatraveller/main.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_images.dart';

import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:keralatraveller/screenforadmin/listofhome.dart';
import 'package:keralatraveller/screens/head_page_user.dart';
import 'package:keralatraveller/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedInAndRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: BackgroundWrapper(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
           const Positioned(
            top: 280,
            child: Text(AppStrings.appNamefirst,style: Apptext.text7,)),
            Positioned(
              left: 10,
              right: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                        AppImages.logimage)),
              ),
            ),
           const Positioned(
            top: 520 ,
            child: Text(AppStrings.appNamesecound,style: Apptext.text7,)),
          ],
        ),
      ),
    );
  }
 Future<void> checkUserLoggedInAndRole() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPrefs.getBool(SAVE_KEY_NAME);
    final isUser = sharedPrefs.getBool(USER_ROLE_KEY);

    if (userLoggedIn == null || userLoggedIn == false && isUser == true) {
      goToLogIn();
    } else {
      if (isUser != null && isUser == true) {
        await Future.delayed(const Duration(seconds: 3), () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ListOfHome(),)));
      } else {
        await Future.delayed(const Duration(seconds: 3), () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HeadPageUser(),)));
      }
    }
  }

  Future<void> goToLogIn() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LogIn(),));
      });
    });
  }
}
