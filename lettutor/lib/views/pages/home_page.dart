import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy_data.dart';
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
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                  child: Text(
                    'You have no upcoming lesson.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    'Welcome to LetTutor!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
