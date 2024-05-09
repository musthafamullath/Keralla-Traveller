import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/login_and_register/widgets/screen_login_page.dart';
import 'package:foodie_fly_restaurant/views/screens/login_and_register/widgets/screen_register_page.dart';

class ScreenLoginRestration extends StatelessWidget {
  const ScreenLoginRestration({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 1.4 / 10),
          child: AppBar(
            backgroundColor: yellow,
            title: const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Foodie Fly Restaurent",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: black,
              unselectedLabelColor: white,
              indicatorWeight: 7.5,
              indicatorColor: black,
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
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
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
