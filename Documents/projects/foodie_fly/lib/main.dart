
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/address/address_bloc.dart';
import 'package:foodie_fly/controller/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:foodie_fly/controller/blocs/cart/cart_bloc.dart';
import 'package:foodie_fly/controller/blocs/category/category_bloc.dart';
import 'package:foodie_fly/controller/blocs/dish/dish_bloc.dart';
import 'package:foodie_fly/controller/blocs/favorites/favorites_bloc.dart';
import 'package:foodie_fly/controller/blocs/login/login_bloc.dart';
import 'package:foodie_fly/controller/blocs/offer/offer_bloc.dart';
import 'package:foodie_fly/controller/blocs/order/order_bloc.dart';
import 'package:foodie_fly/controller/blocs/payment/payment_bloc.dart';
import 'package:foodie_fly/controller/blocs/profile/profile_bloc.dart';
import 'package:foodie_fly/controller/blocs/restaurant/restaurant_bloc.dart';
import 'package:foodie_fly/controller/blocs/sign_up/sign_up_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_password/toggle_password_cubit.dart';
import 'package:foodie_fly/controller/cubits/toggle_repasswod/toggle_repassword_cubit.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/view/screen/splash/screen_splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => BottomNavigationBloc()),
        BlocProvider(create: (context) => TogglepasswordCubit()),
        BlocProvider(create: (context) => ToggleRepasswordCubit()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => DishBloc()),
        BlocProvider(create: (context) => OfferBloc()),
        BlocProvider(create: (context) => RestaurantBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => FavoritesBloc()),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(create: (context) => AddressBloc()),
        BlocProvider(create: (context) => OrderBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foodie Fly',
        theme: ThemeData(
          primaryColor: yellowGreen,
          useMaterial3: true,
          fontFamily: 'K2D',
        ),
        home: const SplashScreenPage(),
      ),
    );
  }
}
