import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/pages/main_view.dart';
import 'package:lettutor/views/authentication/forgot_password_view.dart';
import 'package:lettutor/views/authentication/login_view.dart';
import 'package:lettutor/views/authentication/register_view.dart';
import 'package:lettutor/views/become_tutor_view.dart';
import 'package:lettutor/views/booking_detail_view.dart';
import 'package:lettutor/views/course_detail_view.dart';
import 'package:lettutor/views/teacher_detail_view.dart';
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
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue[600],
                letterSpacing: 1.1),
            headline2: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              //letterSpacing: 1.0,
              color: Colors.blue[600],
            ),
            headline3: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline4: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            bodyText1: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            bodyText2: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
          ),
        ),
        home: const MainView(),
        routes: {
          Routes.login: (context) => const LoginView(),
          Routes.register: (context) => const RegisterView(),
          Routes.forgotPassword: (context) => const ForgotPasswordView(),
          Routes.main: (context) => const MainView(),
          Routes.becomeTutor: (context) => const BecomeTutorView(),
          Routes.userProfile: (context) => const UserProfileView(),
          Routes.courseDetail: (context) => const CourseDetailView(),
          Routes.teacherDetail: (context) => const TeacherDetailView(),
          Routes.bookingDetail: (context) => const BookingDetailView(),
        });
  }
}
