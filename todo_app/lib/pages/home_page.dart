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
              onPressed: () {},
              icon: const Icon(Icons.search, size: 26),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            //padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('All Tasks'),
                onTap: () {
                  setState(() {
                    currentSection = Sections.allTasks;
                  });
                  Navigator.pop(context);
                  // Navigator.pushReplacementNamed(context, Routes.all);
                },
              ),
              ListTile(
                title: const Text('Today'),
                onTap: () {
                  setState(() {
                    currentSection = Sections.today;
                  });
                  Navigator.pop(context);
                  // Navigator.pushNamed(context, Routes.today);
                },
              ),
              ListTile(
                title: const Text('Upcoming'),
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
