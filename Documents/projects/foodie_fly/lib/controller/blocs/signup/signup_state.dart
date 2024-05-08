part of 'signup_bloc.dart';

 class SignupState {}

final class SignupInitial extends SignupState {}

//for success
class SuccessState extends SignupState {}

//for failed
class FailedInvalidfields extends SignupState{}

class FailedToSignupUser extends SignupState{}

class FieldToParseBodyState extends SignupState {}

//for error
class ErrorState extends SignupState {}
