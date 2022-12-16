import 'package:flutter/material.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/constants/routes.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailView> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetailView> {
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
          'Course Details',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/course/course-01.png'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Text(
                'Life in the Internet Age',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Let's discuss how technology is changing the way we live",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Discover',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Overview',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'Why Take This Course?',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 48, right: 16),
              child: Text('Our world is rapidly changing thanks to new technology, '
                  'and the vocabulary needed to discuss modern life is evolving '
                  'almost daily. In this course you will learn the most up-to-date '
                  'terminology from expertly crafted lessons as well from your '
                  'native-speaking tutor.'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'What will you be able to do?',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 48, right: 16),
              child: Text('You will learn vocabulary related to timely topics '
                  'like remote work, artificial intelligence, online privacy, '
                  'and more. In addition to discussion questions, you will practice '
                  'intermediate level speaking tasks such as using data to describe '
                  'trends.'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Experience Level',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.group_add_outlined, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    'Intermediate',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Course Length',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.book_outlined, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '9 Topics',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'List Of Topics',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            // ...List<Widget>.generate(
            //     courseTopics.length,
            //     (index) => Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            //           child: Card(
            //               elevation: 1.5,
            //               surfaceTintColor: Colors.white,
            //               child: ListTile(
            //                   title: Text('${index + 1}. ${courseTopics[index]}'))),
            //         )),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Suggested Tutors',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
              child: Row(
                children: [
                  Text(
                    'Keegan',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(width: 16),
                  TextButton(onPressed: () {
                    Navigator.pushNamed(context, Routes.teacherDetail);
                  }, child: const Text('More Info'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
