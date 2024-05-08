import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foodie_fly/controller/api_sevices/profile/api_calling.dart';
import 'package:foodie_fly/model/profile.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      final profile = await ProfileApiServices().getUserProfile();
      emit(ProfileState(profile: profile));
    });
    on<UpdateUserProfileEvent>((event, emit) async {
      final value = await ProfileApiServices().updateUser(event.profile);
      if (value) {
        // ignore: use_build_context_synchronously
        showSnack(event.context, Colors.green, 'Updated profile successfully');
        final profile = await ProfileApiServices().getUserProfile();
        emit(ProfileState(profile: profile));
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      } else {
        // ignore: use_build_context_synchronously
        showSnack(event.context, Colors.red, 'This email is available.');
      }
    });
  }
}
