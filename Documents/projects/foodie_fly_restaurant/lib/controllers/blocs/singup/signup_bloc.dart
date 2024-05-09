import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/authentication/api_callings.dart';
import 'package:foodie_fly_restaurant/models/restaurant.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SellerSignupEvent>(sellerSignupEvent);
  }

  FutureOr<void> sellerSignupEvent(
SellerSignupEvent event, Emitter<SignupState> emit) async {
    final result =
        await ApiSellerAuthentication().register(event.restaurantRegisteration);
    if (result == "Success") {
      emit(SellerRegistrationSuccessState());
    } else if (result == "failed. invalid fields") {
      emit(SellerRegistrationFailedInvalidfields());
    } else if (result == "failed to Login") {
      emit(SellerRegistrationFailedToLogin());
    } else if (result == "failed to parse body") {
      emit(SellerRegistrationFieldToParseBodyState());
    } else {
      emit(SellerRegistrationErrorState());
    }
  }
}
