import 'package:flutter/material.dart';
import 'package:lettutor/views/login_view.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}
