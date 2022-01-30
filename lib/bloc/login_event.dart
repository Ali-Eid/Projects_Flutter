part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SubmitLoginEvent extends LoginEvent {
  String? email;
  String? password;
  SubmitLoginEvent({this.email, this.password});
}
