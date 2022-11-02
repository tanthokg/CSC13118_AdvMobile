import 'package:flutter/material.dart';
import 'package:todo_app/constants/routes.dart';
import 'package:todo_app/entities/sections.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentSection = Sections.allTasks;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[currentSection] ?? 'No Title'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.search);
              },
              icon: const Icon(Icons.search, size: 26),
            ),
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.075,
              horizontal: 14,
            ),
            child: ListView(
              //padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.list,
                    color: currentSection == Sections.allTasks
                        ? Colors.deepOrange
                        : Colors.black54,
                  ),
                  title: Text(
                    'All Tasks',
                    style: currentSection == Sections.allTasks
                        ? const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                          )
                        : Theme.of(context).textTheme.headline2,
                  ),
                  tileColor: currentSection == Sections.allTasks
                      ? Colors.deepOrange[50]
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onTap: () {
                    setState(() {
                      currentSection = Sections.allTasks;
                    });
                    Navigator.pop(context);
                    // Navigator.pushReplacementNamed(context, Routes.all);
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Icon(
                    Icons.today,
                    color: currentSection == Sections.today
                        ? Colors.deepOrange
                        : Colors.black54,
                  ),
                  title: Text(
                    'Today',
                    style: currentSection == Sections.today
                        ? const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                          )
                        : Theme.of(context).textTheme.headline2,
                  ),
                  tileColor: currentSection == Sections.today
                      ? Colors.deepOrange[50]
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onTap: () {
                    setState(() {
                      currentSection = Sections.today;
                    });
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, Routes.today);
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Icon(
                    Icons.upcoming,
                    color: currentSection == Sections.upcoming
                        ? Colors.deepOrange
                        : Colors.black54,
                  ),
                  title: Text(
                    'Upcoming',
                    style: currentSection == Sections.upcoming
                        ? const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                          )
                        : Theme.of(context).textTheme.headline2,
                  ),
                  tileColor: currentSection == Sections.upcoming
                      ? Colors.deepOrange[50]
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onTap: () {
                    setState(() {
                      currentSection = Sections.upcoming;
                    });
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, Routes.upcoming);
                  },
                ),
              ],
            ),
          ),
        ),
        body: pages[currentSection],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.add);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
