part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeBottomNavBarState extends HomeState {}

class LoadingStateGetUser extends HomeState {}

class SuccessStateGetUser extends HomeState {}

class ErrorStateGetUser extends HomeState {
  String? error;
  ErrorStateGetUser({this.error});
}

//All Users
class LoadingStateGetAllUser extends HomeState {}

class SuccessStateGetAllUser extends HomeState {}

class ErrorStateGetAllUser extends HomeState {
  String? error;
  ErrorStateGetAllUser({this.error});
}

//post
class LoadingStateGetPosts extends HomeState {}

class SuccessStateGetPosts extends HomeState {}

class ErrorStateGetPosts extends HomeState {
  String? error;
  ErrorStateGetPosts({this.error});
}

//dark
class LightandDarkModeState extends HomeState {}

//profile IMG
class SuccessChangeProfileImageState extends HomeState {}

class ErrorChangeProfileImageState extends HomeState {
  String? error;
  ErrorChangeProfileImageState({this.error});
}

class SuccessChangeCoverImageState extends HomeState {}

class ErrorChangeCoverImageState extends HomeState {
  String? error;
  ErrorChangeCoverImageState({this.error});
}

class SuccessUploadCoverImageState extends HomeState {}

class ErrorUploadCoverImageState extends HomeState {
  String? error;
  ErrorUploadCoverImageState({this.error});
}

class SuccessUploadCProfileImageState extends HomeState {}

class LoadUploadImageState extends HomeState {}

class ErrorUploadProfileImageState extends HomeState {
  String? error;
  ErrorUploadProfileImageState({this.error});
}

class ErrorUpdateUserState extends HomeState {
  String? error;
  ErrorUpdateUserState({this.error});
}

class LoadingUpdateUserState extends HomeState {}

class LoadUploadprofileImageState extends HomeState {}

class LoadingPostUserState extends HomeState {}

class SuccessUploadPostState extends HomeState {}

class ErrorUploadPostState extends HomeState {
  String? error;
  ErrorUploadPostState({this.error});
}

class SuccessAddImageToPostState extends HomeState {}

class ErrorAddImageToPostState extends HomeState {
  String? error;
  ErrorAddImageToPostState({this.error});
}

class removeImageFromPostState extends HomeState {}

//Like Post

class SuccessLikePostState extends HomeState {}

class ErrorLikePostState extends HomeState {
  String? error;
  ErrorLikePostState({this.error});
}

//message

class SuccessSendMessageState extends HomeState {}

class ErrorSendMessageState extends HomeState {
  String? error;
  ErrorSendMessageState({this.error});
}

class SuccessGetMessageState extends HomeState {}
