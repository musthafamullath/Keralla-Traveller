import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly_restaurant/controllers/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:foodie_fly_restaurant/views/screens/login_and_register/screen_login_and_registeration.dart';
import 'package:shared_preferences/shared_preferences.dart';

showDialogBOx(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure to logout'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: ()async{
              final preferences = await SharedPreferences.getInstance();
              preferences.setString('token', '');
              SharedPreferences prefers = await SharedPreferences.getInstance();
              prefers.setBool('LOGIN', false);
              // ignore: use_build_context_synchronously
              context.read<BottomNavigationBloc>().add(BottomNavigationEvent(index: 0));
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ScreenLoginRestration(),), (route) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
