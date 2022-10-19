import 'package:flutter/material.dart';
import 'package:lettutor/constants/dummy_data.dart';

class TeacherDetailView extends StatefulWidget {
  const TeacherDetailView({Key? key}) : super(key: key);

  @override
  State<TeacherDetailView> createState() => _TeacherDetailViewState();
}

class _TeacherDetailViewState extends State<TeacherDetailView> {
  final teacher = teachers[0];

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
          'Teacher Details',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(teacher.avatarUrl),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(teacher.name, style: Theme.of(context).textTheme.headline3),
                      Text(teacher.nationality, style: const TextStyle(fontSize: 16)),
                      Row(children: [
                        ...List<Widget>.generate(
                          teacher.reviewScore,
                          (index) => const Icon(Icons.star, color: Colors.amber),
                        ),
                        const SizedBox(width: 8),
                        Text('(${teacher.reviewCount})',
                            style: const TextStyle(fontSize: 18))
                      ])
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(teacher.description, style: const TextStyle(fontSize: 16)),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Icon(Icons.favorite_border, color: Colors.blue),
                        Text('Favorite', style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Icon(Icons.reviews_outlined, color: Colors.blue),
                        Text('Review', style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: const [
                        Icon(Icons.report_outlined, color: Colors.blue),
                        Text('Report', style: TextStyle(color: Colors.blue))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Text(
                'Introduction Video Goes Here',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue[700],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Languages',
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(children: [
                Chip(
                  label: const Text(
                    'English',
                    style: TextStyle(color: Colors.blue),
                  ),
                  backgroundColor: Colors.blue[50],
                ),
              ]),
            ),
            const SizedBox(height: 8),
            Text(
              'Specialties',
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 8,
                runSpacing: -4,
                children: List<Widget>.generate(
                  teacher.specialties.length,
                  (index) => Chip(
                    label: Text(
                      teacher.specialties[index],
                      style: const TextStyle(color: Colors.blue),
                    ),
                    backgroundColor: Colors.blue[50],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Suggested Courses',
              style: Theme.of(context).textTheme.headline3,
            ),
            ...courses.map((course) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        course.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(width: 16),
                      TextButton(onPressed: () {}, child: const Text('View'))
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            Text(
              'Interests',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 8),
              child: Text(
                  'I loved the weather, the scenery and the laid-back lifestyle of the locals.'),
            ),
            const SizedBox(height: 12),
            Text(
              'Teaching Experiences',
              style: Theme.of(context).textTheme.headline3,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 8),
              child: Text('I have more than 10 years of teaching english experience'),
            ),
          ],
        ),
      ),
    );
  }
}
