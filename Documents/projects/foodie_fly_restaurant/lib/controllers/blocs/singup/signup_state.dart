part of 'signup_bloc.dart';

 class SignupState {}

final class SignupInitial extends SignupState {}

//for success
class SellerRegistrationSuccessState extends SignupState {}

//for failed
class SellerRegistrationFailedInvalidfields extends SignupState{}

class SellerRegistrationFailedToLogin extends SignupState{}

class SellerRegistrationFieldToParseBodyState extends SignupState {}

//for error
class SellerRegistrationErrorState extends SignupState {}
