import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/views/authentication/forgot_password_view.dart';
import 'package:lettutor/views/authentication/login_view.dart';
import 'package:lettutor/views/authentication/register_view.dart';
import 'package:lettutor/views/pages/main_view.dart';
import 'package:lettutor/views/user_profile_view.dart';

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
          useMaterial3: true,
          primaryColor: Colors.white,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              letterSpacing: 1.0
            ),
            headline2: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
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
        ),
        home: const LoginView(),
        routes: {
          Routes.login: (context) => const LoginView(),
          Routes.register: (context) => const RegisterView(),
          Routes.forgotPassword: (context) => const ForgotPasswordView(),
          Routes.main: (context) => const MainView(),
          Routes.userProfile: (context) => const UserProfileView(),
        });
  }
}
