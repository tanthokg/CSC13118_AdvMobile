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
            const Text('Basic Info'),
            Row(
              children: [
                Column(
                  children: [
                    Image.asset('assets/user-avatar-01.png', width: 100, height: 100,),
                    TextButton(onPressed: () {}, child: const Text('Upload')),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tutoring Name'),
                      const TextField(),
                      const Text('I am from'),
                      const TextField(),
                      const Text('Date of Birth'),
                      const TextField(),
                    ],
                  ),
                )
              ],
            ),
            const Text('CV'),
            const Text('Interests'),
            const TextField(),
            const Text('Education'),
            const TextField(),
            const Text('Experience'),
            const TextField(),
            const Text('Current or Previous Profession'),
            const TextField(),
            const Text('Certificate'),
            TextButton(onPressed: () {}, child: const Text('Add New Certificate')),
            const Text('Languages I speak'),
            const Text('Languages'),
            const TextField(),
            const Text('Who I teach'),
            const Text('Introduction'),
            const TextField(),
            const Text('I am best at teaching students who are'),
            const TextField(),
            const Text('My specialties are'),
            const TextField(),
            const Text('Introduction Video'),
            TextButton(onPressed: () {}, child: const Text('Choose Video')),
            TextButton(onPressed: () {}, child: const Text('Done')),
          ],
      ),
      ),
    );
  }
}
