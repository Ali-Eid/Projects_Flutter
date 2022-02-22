import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/layout/home.dart';
import 'package:dardesh/module/Login/login_screen.dart';
import 'package:dardesh/module/Signup/cubit/signup_cubit.dart';
import 'package:dardesh/shared/cach_helper.dart';
import 'package:dardesh/shared/components/components.dart';
import 'package:dardesh/shared/constants.dart';
import 'package:dardesh/shared/style/theme.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> _RemoteMSGBackground(RemoteMessage msg) async {
  showToast(
      message: 'on backGround Msg Notification', state: ToastState.success);
}

void main() async {
  //بيتأكد انو كلو خلص بعدين بيفتح الابليكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('${token}');
  //forground FCM msg
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(
        message: 'on Message Msg Notification', state: ToastState.success);
  });
  //forground FCM msg when opened app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(
        message: 'on opened app Msg Notification', state: ToastState.success);
  });
  //background FCM msg
  FirebaseMessaging.onBackgroundMessage(_RemoteMSGBackground);

  await CacheHelper.init();
  uid = CacheHelper.getData(key: 'token');
  // mode = CacheHelper.getData(key: 'dark');
  Widget? startWidget;

  if (uid != null) {
    startWidget = HomePage();
  } else {
    startWidget = LoginPage();
  }
  print(CacheHelper.getData(key: 'mode'));
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  Widget? startWidget;
  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit()
              ..getUser()
              ..getPosts(),
          ),
          // BlocProvider(
          //   create: (context) => SignupCubit(),
          // ),
        ],
        child: MaterialApp(
            theme: mode ? themeDark : themeLigth, home: startWidget));
  }
}
