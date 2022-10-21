import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy_data.dart';
import 'package:lettutor/constants/routes.dart';
import 'package:lettutor/widgets/teacher_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue[700],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Upcoming Lesson',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '2022-10-21  18:30-18:55',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.videoCall);
                        },
                        child: const Text('Join', style: TextStyle(fontSize: 16)))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 24),
                  child: Text(
                    'Total Lesson Time: 4 hours 30 minutes',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
            child: Text(
              'Recommended Tutors',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          ...teachers.map((e) => TeacherCard(teacher: e)),
        ],
      ),
    );
  }
}
