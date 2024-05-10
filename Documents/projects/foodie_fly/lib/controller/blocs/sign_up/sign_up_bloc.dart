

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foodie_fly/controller/api_sevices/sign_up_login/api_calling.dart';
import 'package:foodie_fly/model/user.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';


part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      bool value = await ApiServices().signUp(event.user);
      if (value) {
        emit(SignUpState(isLoading: false));
        Navigator.of(event.context).push(
          MaterialPageRoute(
            builder: (context) => ScreenMainPage(),
          ),
        );
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(
            content: const Text('Account created successfully'),
          ),
        );
      }
    });
  }
}