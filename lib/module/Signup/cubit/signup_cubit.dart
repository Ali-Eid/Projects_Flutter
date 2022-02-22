import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dardesh/model/user_model.dart';
import 'package:dardesh/module/Signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  static SignupCubit get(context) => BlocProvider.of(context);

  void SignUp({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(LoadingStateSignIn());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CreateUser(
          username: username, email: email, phone: phone, uid: value.user!.uid);
      // emit(SuccessStateSignIn());
    }).catchError((error) {});
  }

  void CreateUser({
    required String username,
    required String email,
    required String phone,
    required String uid,
    String? bio,
    String? image,
    String? cover,
    bool? isEmailVerification = false,
  }) {
    UserModel model = UserModel(
        email: email,
        name: username,
        phone: phone,
        uid: uid,
        bio: 'write your bio ...',
        image:
            'https://img.freepik.com/free-photo/positive-curly-young-woman-dressed-yellow-comfortable-sweater-holds-chin-looks-aside-with-dreamy-expression-has-interesting-idea-mind-isolated-blue-background_273609-34288.jpg',
        cover:
            'https://img.freepik.com/free-photo/positive-curly-young-woman-dressed-yellow-comfortable-sweater-holds-chin-looks-aside-with-dreamy-expression-has-interesting-idea-mind-isolated-blue-background_273609-34288.jpg');
    // emit(LoadingStateSignIn());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SuccessStateCreateUser(uid: uid));
    }).catchError((error) {
      emit(ErrorStateCreateUser(error: error.toString()));
    });
  }
}
