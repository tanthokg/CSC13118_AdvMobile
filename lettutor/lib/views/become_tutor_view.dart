import 'package:flutter/material.dart';

class BecomeTutorView extends StatefulWidget {
  const BecomeTutorView({Key? key}) : super(key: key);

  @override
  State<BecomeTutorView> createState() => _BecomeTutorViewState();
}

class _BecomeTutorViewState extends State<BecomeTutorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Become Tutor',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Basic Info'),
            Row(
              children: [
                Column(
                  children: [
                    Image.asset('assets/user-avatar-01.png', width: 100, height: 100,),
                    TextButton(onPressed: () {}, child: const Text('Upload')),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tutoring Name'),
                      TextField(),
                      Text('I am from'),
                      TextField(),
                      Text('Date of Birth'),
                      TextField(),
                    ],
                  ),
                )
              ],
            ),
            Text('CV'),
            Text('Interests'),
            TextField(),
            Text('Education'),
            TextField(),
            Text('Experience'),
            TextField(),
            Text('Current or Previous Profession'),
            TextField(),
            Text('Certificate'),
            TextButton(onPressed: () {}, child: Text('Add New Certificate')),
            Text('Languages I speak'),
            Text('Languages'),
            TextField(),
            Text('Who I teach'),
            Text('Introduction'),
            TextField(),
            Text('I am best at teaching students who are'),
            TextField(),
            Text('My specialties are'),
            TextField(),
            Text('Introduction Video'),
            TextButton(onPressed: () {}, child: Text('Choose Video')),
            TextButton(onPressed: () {}, child: Text('Done')),
          ],
      ),
      ),
    );
  }
}
