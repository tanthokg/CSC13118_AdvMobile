import 'package:flutter/material.dart';
import 'package:lettutor/constants/datatype.dart';
import 'package:lettutor/constants/dummy_data.dart';
import 'package:lettutor/widgets/teacher_card.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int chosenFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/logo.png'),
        title: Text(
          'LetTutor',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.translate, color: Colors.blue),
            itemBuilder: (context) => const [
              PopupMenuItem<Language>(
                value: Language.english,
                child: Text('English'),
              ),
              PopupMenuItem<Language>(
                value: Language.vietnamese,
                child: Text('Vietnamese'),
              ),
            ],
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.list, color: Colors.blue),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('htho379'),
            ),
            ListTile(
              leading: Icon(Icons.add_card, color: Colors.blue),
              title: Text('Buy Lessons'),
            ),
            ListTile(
              leading: Icon(Icons.key, color: Colors.blue),
              title: Text('Change Password'),
            ),
            ListTile(
              leading: Icon(Icons.personal_video, color: Colors.blue),
              title: Text('Tutor'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.blue),
              title: Text('Schedule'),
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.blue),
              title: Text('History'),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.blue),
              title: Text('Courses'),
            ),
            ListTile(
              leading: Icon(Icons.menu_book, color: Colors.blue),
              title: Text('My Course'),
            ),
            ListTile(
              leading: Icon(Icons.laptop, color: Colors.blue),
              title: Text('Become A Tutor'),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.blue),
              title: Text('Log Out'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
              child: Text('Find a tutor', style: Theme.of(context).textTheme.headline3),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                children: const [
                  SizedBox(width: 170, child: TextField()),
                  SizedBox(width: 20),
                  SizedBox(width: 170, child: TextField()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
              child: Text('Select available tutoring time:',
                  style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                children: const [
                  SizedBox(width: 140, child: TextField()),
                  SizedBox(width: 20),
                  SizedBox(width: 200, child: TextField()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Wrap(
                spacing: 4,
                runSpacing: -6,
                children: List<Widget>.generate(
                  filters.length,
                  (index) => ChoiceChip(
                    label: Text(
                      filters[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: chosenFilter == index ? Colors.blue : Colors.black54,
                      ),
                    ),
                    selectedColor: Colors.lightBlue[50],
                    selected: chosenFilter == index,
                    onSelected: (bool selected) {
                      setState(() {
                        chosenFilter = index;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    chosenFilter = 0;
                  });
                },
                child: const Text('Reset Filters'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Divider(
                thickness: 2,
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
      ),
    );
  }
}
