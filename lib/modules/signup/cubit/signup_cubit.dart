import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/login_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);
  LoginModel? userModel;
  void signUP({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(LoadingStateSignIn());
    DioHelper.postData(url: REGISTER, data: {
      'name': username,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel);
      emit(SuccessStateSignIn(userModel: userModel));
    }).catchError((error) {
      emit(ErrorStateSignIn());
    });
  }
}
