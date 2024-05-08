import 'package:flutter/material.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/signup_login/widgets/screen_login_page.dart';
import 'package:foodie_fly/view/screen/signup_login/widgets/screen_signup_page.dart';

class ScreenLoginRestration extends StatelessWidget {
  const ScreenLoginRestration({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 1.3 / 10),
          child: AppBar(
            backgroundColor: yellowGreen,
            title:const Padding(
              padding:  EdgeInsets.only(top: 20),
              child:  Text(
                "Foodie Fly",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: white,
                    wordSpacing: 1.5),
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: white,
              unselectedLabelColor: black,
              indicatorWeight: 7.5,
              indicatorColor: white,
              indicatorPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            ScreenLoginPage(),
            ScreenRegisterPage(),
          ],
        ),
      ),
    );
  }
}
