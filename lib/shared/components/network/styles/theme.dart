import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
    primarySwatch: Colors.deepOrange,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.deepOrange,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
    ),
    fontFamily: 'Jannah',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange));
