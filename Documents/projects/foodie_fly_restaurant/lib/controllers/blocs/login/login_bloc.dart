import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/authentication/api_callings.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SellerLoginEvent>(sellerLoginEvent);
  }
  FutureOr<void> sellerLoginEvent(SellerLoginEvent event, Emitter<LoginState> emit) async{
    final result = await ApiSellerAuthentication().login(event.email,event.password);
    if(result == "success"){
      
      emit(SellerLoginSuccessState());  
    }else if(result == "failed. invalid fields"){
      
      emit(SellerLoginFailedInvalidFields());
    }else if(result == "failed to Login"){
      emit(SellerLoginFailedToLogin());
    }
    else if(result == "failed to parse body"){
      
      emit(SellerLoginFieldToParseBodyState());
    }else{
     
      emit(SellerLoginErrorState());
    }
  }
}
