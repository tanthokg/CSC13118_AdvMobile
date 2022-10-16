import 'package:flutter/material.dart';
import 'package:lettutor/views/login_view.dart';
import 'package:lettutor/views/register_view.dart';

void main() {
  runApp(const LetTutor());
}

class LetTutor extends StatelessWidget {
  const LetTutor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetTutor',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
          headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.blue),
          bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
      ),
      home: const RegisterView(),
    );
  }
}
