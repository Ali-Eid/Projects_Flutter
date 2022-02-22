import 'package:bloc/bloc.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dardesh/model/message_model.dart';
import 'package:dardesh/model/post_model.dart';
import 'package:dardesh/model/user_model.dart';
import 'package:dardesh/module/Login/cubit/login_cubit.dart';
import 'package:dardesh/module/chats/chats_screen.dart';
import 'package:dardesh/module/feeds/feeds_screen.dart';
import 'package:dardesh/module/settings/settings_screen.dart';
import 'package:dardesh/module/users/users_screen.dart';
import 'package:dardesh/shared/cach_helper.dart';
import 'package:dardesh/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  void getUser() {
    emit(LoadingStateGetUser());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'token'))
        .get()
        .then((value) {
      model = UserModel.fromJson(value.data());
      // print(value.data());
      emit(SuccessStateGetUser());
    }).catchError((error) {
      print('Error is : ${error.toString()}');
      emit(ErrorStateGetUser(error: error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingScreen()
  ];

  List<String> appBarTitle = ['Home', 'Chat', 'Users', 'Settings'];

  int currentindex = 0;
  void changeBotomNav(int index) {
    currentindex = index;
    if (index == 1) {
      getAllUsers();
      // emit(ChangeBottomNavBarState());
    }
    emit(ChangeBottomNavBarState());
  }

  bool isSwitched = false;

  void changeMode(bool value) {
    CacheHelper.saveData(key: 'dark', value: value);
    isSwitched = value;
    mode = CacheHelper.getData(key: 'dark');
    emit(LightandDarkModeState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future changeProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SuccessChangeProfileImageState());
    } else {
      emit(ErrorChangeProfileImageState());
    }
  }

  File? coverImage;
  // var picker = ImagePicker();

  Future changeCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SuccessChangeCoverImageState());
    } else {
      emit(ErrorChangeCoverImageState());
    }
  }

  // String profileImagURL = '';
  void uploadProfileImage({
    required String username,
    required String bio,
    required String phone,
  }) {
    emit(LoadUploadprofileImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(username: username, bio: bio, phone: phone, profile: value);
        // emit(SuccessUploadCProfileImageState());
      }).catchError((error) {
        emit(ErrorUploadProfileImageState());
      });
    }).catchError((error) {
      emit(ErrorUploadProfileImageState());
    });
  }

  // String coverImagURL = '';
  void uploadCoverImage({
    required String username,
    required String bio,
    required String phone,
  }) {
    emit(LoadUploadImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print(value);

        updateUser(username: username, bio: bio, phone: phone, cover: value);

        // emit(SuccessUploadCoverImageState());
      }).catchError((error) {
        emit(ErrorUploadCoverImageState());
      });
    }).catchError((error) {
      emit(ErrorUploadCoverImageState());
    });
  }

  void updateUser(
      {required String username,
      required String bio,
      required String phone,
      String? cover,
      String? profile}) {
    UserModel usermodel = UserModel(
        name: username,
        uid: model!.uid,
        email: model!.email,
        phone: phone,
        bio: bio,
        image: profile ?? model!.image,
        cover: cover ?? model!.cover);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .update(usermodel.toMap())
        .then((value) {
      //no need to emit because getUser inside emit state
      getUser();
    }).catchError((error) {
      emit(ErrorUpdateUserState());
    });
  }

  File? postImageFile;
  Future addImageToPost() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImageFile = File(pickedFile.path);
      emit(SuccessAddImageToPostState());
    } else {
      emit(ErrorAddImageToPostState());
    }
  }

  void uploadPostImag({
    required String name,
    required String text,
    required String date,
    required String image,
    String? postimage,
  }) {
    emit(LoadingPostUserState());
    if (postImageFile == null) {
      uploadPost(name: name, text: text, date: date, image: image);
    } else {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(postImageFile!.path).pathSegments.last}')
          .putFile(postImageFile!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          print(value);
          uploadPost(
              name: name,
              date: date,
              text: text,
              image: image,
              postimage: value);
          // emit(SuccessUploadCoverImageState());
        }).catchError((error) {
          emit(ErrorUploadCoverImageState());
        });
      }).catchError((error) {
        emit(ErrorUploadCoverImageState());
      });
    }
  }

  void uploadPost({
    required String name,
    required String text,
    required String date,
    required String image,
    String? postimage,
  }) {
    emit(LoadingPostUserState());
    PostModel postmodel = PostModel(
        name: name, date: date, text: text, image: image, postimage: postimage);
    FirebaseFirestore.instance
        .collection('posts')
        .add(postmodel.toMap())
        .then((value) {
      posts = [];
      getPosts();
      emit(SuccessUploadPostState());
      //no need to emit because getUser inside emit state
    }).catchError((error) {
      emit(ErrorUploadPostState());
    });
  }

  void removePhotoPost() {
    postImageFile = null;
    emit(removeImageFromPostState());
  }

  List<PostModel> posts = [];
  List<String> postID = [];
  List<int> likes = [];
  void getPosts() {
    // posts = [];
    emit(LoadingStateGetPosts());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('like').get().then((value) {
          likes.add(value.docs.length);
          postID.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          posts.sort((a, b) {
            return (b.date)!.compareTo(a.date!);
          });

          emit(SuccessStateGetPosts());
        }).catchError((error) {});
      });
      // posts.reversed.toList();
      emit(SuccessStateGetPosts());
    }).catchError((error) {
      print('Error is : ${error.toString()}');
      emit(ErrorStateGetPosts(error: error.toString()));
    });
//     FirebaseFirestore.instance.collection('posts').snapshots().listen((eve) {
//       posts = [];
//       likes = [];
//       postID = [];
//       eve.docs.forEach((element) {
//         element.reference.collection('like').snapshots().listen((event) {
//           likes.add(event.docs.length);
//           postID.add(element.id);
//           posts.add(PostModel.fromJson(element.data()));
//           emit(SuccessStateGetPosts());
//         });
//       });
//     });
// //   });
  }

  void likePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('like')
        .doc(postid)
        .set({'Like': true}).then((value) {
      emit(SuccessLikePostState());
    }).catchError((error) {
      emit(ErrorLikePostState(error: error.toString()));
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model!.uid)
            users.add(UserModel.fromJson(element.data()));
          emit(SuccessStateGetAllUser());
        });
      }).catchError((error) {
        emit(ErrorStateGetAllUser());
      });
  }

  void sendMessage({
    required String recieveID,
    required String dateTime,
    required String text,
  }) {
    MessageModel messagemodel = MessageModel(
        sendID: model!.uid,
        reciveID: recieveID,
        dateTime: dateTime,
        text: text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid!)
        .collection('chats')
        .doc(recieveID)
        .collection('message')
        .add(messagemodel.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieveID)
        .collection('chats')
        .doc(model!.uid!)
        .collection('message')
        .add(messagemodel.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError((error) {
      emit(ErrorSendMessageState());
    });
  }

  List<MessageModel> messages = [];
  void getMessage({required String recieveID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(recieveID)
        .collection('message')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        // emit(SuccessGetMessageState());
      });
      emit(SuccessGetMessageState());
    });
  }
}
