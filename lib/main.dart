import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/bloc/shop/bloc/favorites/bloc/favourites_bloc.dart';
import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';

import 'package:softagi/layout/home_layout.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:softagi/shared/components/network/styles/theme.dart';
import 'package:softagi/shared/constants.dart';

import 'layout/page_order.dart';
import 'modules/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginPage();
    }
  } else {
    widget = PageOrder();
  }
  // print(onBoarding);
  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startwidget;
  MyApp({this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopBloc()..add(GetDataHome())),
        // BlocProvider(create: (context) => FavouritesBloc()),
      ],
      child: MaterialApp(
        theme: theme,
        home: startwidget,
      ),
    );
  }
}
