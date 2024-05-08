import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodie_fly/controller/api_sevices/sign_up_login/api_calling.dart';
import 'package:foodie_fly/model/user.dart';


part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>(signupEvent);
  }

  FutureOr<void> signupEvent(
     SignupEvent event, Emitter<SignupState> emit) async {
    final result =
        await ApiAuthentication.signup(event.user);
    if (result == "Success") {
      emit(SuccessState());
    } else if (result == "failed. invalid fields") {
      emit(FailedInvalidfields());
    } else if (result == "failed to signup user") {
      emit(FailedToSignupUser());
    } else if (result == "failed to parse body") {
      emit(FieldToParseBodyState());
    } else {
      emit(ErrorState());
    }
  }
}
