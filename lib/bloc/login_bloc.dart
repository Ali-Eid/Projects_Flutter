import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/login_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SubmitLoginEvent>((event, emit) async {
      try {
        emit(LoadingStateLogIn());
        var data = await DioHelper.postData(
            url: 'login',
            data: {'email': event.email, 'password': event.password});
        LoginModel loginmodel = LoginModel.fromJson(data.data);

        data == null
            ? emit(ErrorStateLogIn())
            : emit(SuccessStateLogIn(loginmodel: loginmodel));
      } catch (error) {
        emit(ErrorStateLogIn());
      }
    });
  }
}
