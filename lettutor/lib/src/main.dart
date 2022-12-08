import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/authentication/forgot_password_view.dart';
import 'package:lettutor/src/features/authentication/login_view.dart';
import 'package:lettutor/src/features/authentication/register_view.dart';
import 'package:lettutor/src/features/navigation/navigation_page.dart';

import 'package:lettutor/src/features/user_profile/become_tutor_view.dart';
import 'package:lettutor/src/features/booking/booking_detail_view.dart';
import 'package:lettutor/src/features/courses/course_detail_view.dart';
import 'package:lettutor/src/features/tutor/tutor_detail_view.dart';
import 'package:lettutor/src/features/tutor/tutor_review_view.dart';
import 'package:lettutor/src/features/user_profile/user_profile_view.dart';
import 'package:lettutor/src/features/video_call/video_call_view.dart';
import 'package:lettutor/src/features/tutor/write_review_view.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const LetTutor());
}

class LetTutor extends StatelessWidget {
  const LetTutor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
          title: 'LetTutor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
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
          home: const LoginView(),
          routes: {
            Routes.login: (context) => const LoginView(),
            Routes.register: (context) => const RegisterView(),
            Routes.forgotPassword: (context) => const ForgotPasswordView(),
            Routes.main: (context) => const NavigationPage(),
            Routes.becomeTutor: (context) => const BecomeTutorView(),
            Routes.userProfile: (context) => const UserProfileView(),
            Routes.courseDetail: (context) => const CourseDetailView(),
            Routes.teacherDetail: (context) => const TutorDetailView(),
            Routes.bookingDetail: (context) => const BookingDetailView(),
            Routes.review: (context) => const TutorReviewView(),
            Routes.writeReview: (context) => const WriteReviewView(),
            Routes.videoCall: (context) => const VideoCallView(),
          }),
    );
  }
}