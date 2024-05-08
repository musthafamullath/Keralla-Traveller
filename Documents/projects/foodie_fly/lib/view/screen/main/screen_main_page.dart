import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/cart/screen_cart.dart';
import 'package:foodie_fly/view/screen/home/screen_home.dart';
import 'package:foodie_fly/view/screen/main/widgets/salomonbottombar.dart';
import 'package:foodie_fly/view/screen/orders/screen_orders.dart';
import 'package:foodie_fly/view/screen/profile/screen_profile.dart';
import 'package:foodie_fly/view/screen/restaurants/screen_restaurant.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});
  final List screens = [
    const ScreenHome(),
    const ScreenRestaurants(),
    ScreenCart(),
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
            curve: Curves.decelerate,
            currentIndex: state.index,
            onTap: (value) => context
                .read<BottomNavigationBloc>()
                .add(BottomNavigationEvent(index: value)),
            items: [
              salomonbottombaritem(
                  const ImageIcon(AssetImage("assets/icons/foods.png")),
                  'Foods'),
              salomonbottombaritem(
                  const ImageIcon(AssetImage("assets/icons/restaurant.png")),
                  'Restaurant'),
              salomonbottombaritem(
                  const ImageIcon(AssetImage("assets/icons/cart.png")), 'Cart'),
              salomonbottombaritem(
                  const ImageIcon(AssetImage("assets/icons/ordericon.png")), 'Orders'),
              salomonbottombaritem(
                  const ImageIcon(AssetImage("assets/icons/profile.png")),
                  'Profile'),
            ],
          ),
        );
      },
    );
  }
}
