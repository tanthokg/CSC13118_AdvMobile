import 'package:flutter/material.dart';
import 'package:todo_app/constants/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Tasks'),
        ),
        drawer: Drawer(
          child: ListView(
            //padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('All Tasks'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.all);
                },
              ),
              ListTile(
                title: const Text('Today'),
                onTap: () {
                  Navigator.pushNamed(context, Routes.today);
                },
              ),
              ListTile(
                title: const Text('Upcoming'),
                onTap: () {
                  Navigator.pushNamed(context, Routes.upcoming);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
