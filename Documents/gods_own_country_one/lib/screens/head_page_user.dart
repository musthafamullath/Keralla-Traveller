import 'package:flutter/material.dart';
import 'package:keralatraveller/refacteredclasses/app_bottomnavigatoruser.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_icons.dart';
import 'package:keralatraveller/screens/profile_page.dart';
import 'package:keralatraveller/screens/favirote_page.dart';
import 'package:keralatraveller/screens/home_page.dart';

class HeadPageUser extends StatefulWidget {
  const HeadPageUser({super.key});

  @override
  State<HeadPageUser> createState() => _HeadPageUserState();
}

class _HeadPageUserState extends State<HeadPageUser> {
  Menususer iconClick = Menususer.home;
  final pages = [
    const HomePage(),
    const FavirotePage(),
    const AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BackgroundWrapper(
        child: pages[iconClick.index]),
      bottomNavigationBar: MyBottomNavigations(
        iconClick: iconClick,
        onTap: (value) {
          setState(() {
            iconClick = value;
          });
        },
      ),
    );
  }
}

enum Menususer {
  home,
  favirote,
  account,
}

class MyBottomNavigations extends StatelessWidget {
  final Menususer iconClick;
  final ValueChanged<Menususer> onTap;
  const MyBottomNavigations(
      {super.key, required this.iconClick, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      margin: const EdgeInsets.only(left: 90, right: 90),
      child: Stack(
        children: [
          Positioned(
            top: 17,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbottomnavigatorsUser(
                      onPressed: () => onTap(Menususer.home),
                      icon: AppIcons.icon3,
                      iconClick: iconClick,
                      name: Menususer.home),
                      
                  AppbottomnavigatorsUser(
                      onPressed: () => onTap(Menususer.favirote),
                      icon: AppIcons.icon5,
                      iconClick: iconClick,
                      name: Menususer.favirote),
                    
                  AppbottomnavigatorsUser(
                      onPressed: () => onTap(Menususer.account),
                      icon: AppIcons.icon6,
                      iconClick: iconClick,
                      name: Menususer.account),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
