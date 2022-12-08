import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/features/courses/courses_page.dart';
import 'package:lettutor/src/features/homepage/homepage.dart';
import 'package:lettutor/src/features/schedules/schedule_page.dart';
import 'package:lettutor/src/features/settings/settings_page.dart';
import 'package:lettutor/src/features/tutor/tutor_search_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> pages = [
    const HomePage(),
    const TutorSearchPage(),
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
        elevation: 0,
        backgroundColor: Colors.white,
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
                      backgroundImage: AssetImage('assets/user/user-avatar-01.png'),
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
          BottomNavigationBarItem(icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
