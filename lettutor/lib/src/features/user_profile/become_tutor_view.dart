import 'package:flutter/material.dart';
import 'package:lettutor/src/widgets/select_date.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Basic Info',
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/user/user-avatar-01.png',
                      width: 100,
                      height: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Upload'),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tutoring Name',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 2),
                      const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'I am from',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 2),
                      const TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date of Birth',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 2),
                      SelectDate(date: '',),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'CV',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            Text(
              'Interests',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Education',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Experience',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Current or Previous Profession',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Certificate',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Add New Certificate'),
            ),
            const SizedBox(height: 16),
            Text(
              'Languages I speak',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            Text(
              'Languages',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Who I teach',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 8),
            Text(
              'Introduction',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'I am best at teaching students who are',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'My specialties are',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2),
            const TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Introduction Video',
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextButton(
                onPressed: () {},
                child: const Text('Choose Video'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Colors.blue),
                onPressed: () {},
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
