import 'package:flutter/material.dart';
import 'package:todo_app/constants/routes.dart';
import 'package:todo_app/pages/all_page.dart';
import 'package:todo_app/pages/today_page.dart';
import 'package:todo_app/pages/upcoming_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTodo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const AllPage(),
      routes: {
        Routes.all: (context) => const AllPage(),
        Routes.today: (context) => const TodayPage(),
        Routes.upcoming: (context) => const UpcomingPage(),
      },
    );
  }
}

