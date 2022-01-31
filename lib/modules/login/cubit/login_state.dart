part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingStateLogIn extends LoginState {}

class SuccessStateLogIn extends LoginState {
  LoginModel? loginmodel;
  SuccessStateLogIn({this.loginmodel});
}

class ErrorStateLogIn extends LoginState {
  String? error;
  ErrorStateLogIn({this.error});
}
