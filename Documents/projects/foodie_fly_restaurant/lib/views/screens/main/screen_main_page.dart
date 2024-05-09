import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/screens/home/screen_home.dart';
import 'package:foodie_fly_restaurant/views/screens/main/widgets/salomonbottombaritem.dart';
import 'package:foodie_fly_restaurant/views/screens/offer/screen_offer.dart';
import 'package:foodie_fly_restaurant/views/screens/orders/screen_orders.dart';
import 'package:foodie_fly_restaurant/views/screens/profile/screen_profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});
  
  final List screens = [
    const ScreenHome(),
    const ScreenOffers(),
    const ScreenOrders(),
    const ScreenProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.index],
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: black,
            selectedItemColor: white,
            unselectedItemColor: white,
            curve: Curves.decelerate,
            currentIndex: state.index,
            onTap: (value) => context
                .read<BottomNavigationBloc>()
                .add(BottomNavigationEvent(index: value)),
            items: [
              salomonbottombaritem(const ImageIcon(AssetImage("assets/icons/foods.png")), 'Menu'),
              salomonbottombaritem(const ImageIcon(AssetImage("assets/icons/cart.png")), 'Offers'),
              salomonbottombaritem(const ImageIcon(AssetImage("assets/icons/restaurant.png")), 'Orders'),
              salomonbottombaritem(const ImageIcon(AssetImage("assets/icons/profile.png")), 'Profile'),
            ],
          ),
        );
      },
    );
  }


}
