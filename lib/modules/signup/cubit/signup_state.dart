part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class LoadingStateSignIn extends SignupState {}

class SuccessStateSignIn extends SignupState {
  LoginModel? userModel;
  SuccessStateSignIn({this.userModel});
}

class ErrorStateSignIn extends SignupState {}
