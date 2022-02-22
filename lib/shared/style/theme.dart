import 'package:flutter/material.dart';

ThemeData themeLigth = ThemeData(
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    fontFamily: 'Jannah',
    textTheme: TextTheme(
        // caption: TextStyle(color: Colors.white),
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(fontSize: 12, color: Colors.black, height: 1.4)),
    backgroundColor: Colors.white,
    primarySwatch: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(fontFamily: 'Jannah'),
        elevation: 15,
        backgroundColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6)),
    // fontFamily: 'Jannah',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            fontFamily: 'Jannah',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black)),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.purple));

ThemeData themeDark = ThemeData(
    iconTheme: IconThemeData(color: Colors.white),
    cardColor: Colors.black,
    backgroundColor: Colors.black,
    textTheme: TextTheme(
        caption: TextStyle(color: Colors.white),
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(fontSize: 12, color: Colors.white, height: 1.4)),
    primarySwatch: Colors.purple,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(fontFamily: 'Jannah'),
        elevation: 15,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white.withOpacity(0.6)),
    // fontFamily: 'Jannah',
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.purple),
        titleTextStyle: TextStyle(
            fontFamily: 'Jannah',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.purple),
        backgroundColor: Colors.black,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.purple)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple,
    ));
