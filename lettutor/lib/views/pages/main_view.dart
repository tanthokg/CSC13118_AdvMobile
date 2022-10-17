import 'package:flutter/material.dart';
import 'package:lettutor/views/pages/home_page.dart';
import 'package:lettutor/views/pages/settings_page.dart';
import 'package:lettutor/views/pages/tutors_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const TutorsPage(),
    const SettingsPage(),
  ];
  List<String> pagesTitle = ['Home', 'Tutors', 'Settings'];
  int chosenPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pagesTitle[chosenPageIndex]),
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
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
