
// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foodie_fly/controller/api_sevices/sign_up_login/api_calling.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';


part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      final value = await ApiServices().login(event.email, event.password);
      if (value) {
        emit(LoginState(isLoading: false));
        showSnack(event.context, Colors.green, 'Logged successfully');
        Navigator.of(event.context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenMainPage(),
          ),
        );
      } else {
        showSnack(event.context, Colors.red, 'Invalid entries');
      }
    });
  }
}