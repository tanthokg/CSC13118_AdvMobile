import 'package:flutter/material.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/pages/courses_page.dart';
import 'package:lettutor/pages/home_page.dart';
import 'package:lettutor/pages/schedule_page.dart';
import 'package:lettutor/pages/settings_page.dart';
import 'package:lettutor/pages/tutors_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const TutorsPage(),
    const SchedulePage(),
    const CoursesPage(),
    const SettingsPage(),
  ];
  List<String> pagesTitle = ['Home', 'Tutors', 'Schedule', 'Courses', 'Settings'];
  int chosenPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pagesTitle[chosenPageIndex],
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: chosenPageIndex == 0
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.userProfile);
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/user-avatar-01.png'),
                    ),
                  ),
                )
              ]
            : [],
      ),
      body: pages[chosenPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            chosenPageIndex = value;
          });
        },
        elevation: 20,
        currentIndex: chosenPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Tutors'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
