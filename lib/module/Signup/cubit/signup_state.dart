part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class LoadingStateSignIn extends SignupState {}

class SuccessStateSignIn extends SignupState {}

class ErrorStateSignIn extends SignupState {
  String? error;
  ErrorStateSignIn({this.error});
}

class SuccessStateCreateUser extends SignupState {
  String? uid;
  SuccessStateCreateUser({this.uid});
}

class ErrorStateCreateUser extends SignupState {
  String? error;
  ErrorStateCreateUser({this.error});
}
