import 'package:flutter/material.dart';

final appTheme =  ThemeData(
  useMaterial3: true,
  primaryColor: Colors.blue,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        letterSpacing: 1.1
    ),
    headline2: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.0,
      color: Colors.blue,
    ),
    headline3: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
  ),
);
