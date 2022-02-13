import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/login_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:softagi/shared/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  void SubmitLogin({required String email, required String password}) {
    emit(LoadingStateLogIn());
    var data = DioHelper.postData(
        url: LOGIN, data: {'email': email, 'password': password}).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      // CacheHelper.saveData(key: 'token', value: '${loginModel!.data!.token}');
      emit(SuccessStateLogIn(loginmodel: loginModel));
    }).catchError((error) {
      emit(ErrorStateLogIn(error: error));
    });
  }
}
