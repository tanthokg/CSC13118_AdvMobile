import 'package:flutter/material.dart';
import 'package:todo_app/constants/routes.dart';
import 'package:todo_app/pages/all_tasks_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/today_page.dart';
import 'package:todo_app/pages/upcoming_page.dart';
import 'package:todo_app/views/add_task_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTodo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepOrange,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          headline3: TextStyle(fontSize: 16),
        )
      ),
      home: const HomePage(),
      routes: {
        Routes.all: (context) => const AllTasksPage(),
        Routes.today: (context) => const TodayPage(),
        Routes.upcoming: (context) => const UpcomingPage(),
        Routes.add: (context) => const AddTaskView(),
      },
    );
  }
}

