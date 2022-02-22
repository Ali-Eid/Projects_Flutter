import 'package:bloc/bloc.dart';
import 'package:dardesh/model/user_model.dart';
import 'package:dardesh/shared/cach_helper.dart';
import 'package:dardesh/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void SubmitLogin({required String email, required String password}) {
    emit(LoadingStateLogIn());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('TOKEN IS : ${value.user!.uid}');
      CacheHelper.saveData(key: 'token', value: value.user!.uid);
      print('TOKEN 2  IS : ${CacheHelper.getData(key: 'token')}');
      emit(SuccessStateLogIn(uid: value.user!.uid));
    }).catchError((error) {
      emit(ErrorStateLogIn(error: error.toString()));
    });
  }
}
