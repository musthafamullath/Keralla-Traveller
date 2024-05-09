part of 'login_bloc.dart';

 class LoginEvent {}
class SellerLoginEvent extends LoginEvent{
  final String email;
  final String password;

  SellerLoginEvent({required this.email, required this.password});

}
