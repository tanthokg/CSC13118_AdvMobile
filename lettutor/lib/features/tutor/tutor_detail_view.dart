import 'package:flutter/material.dart';
import 'package:lettutor/dummy/dummy_data.dart';
import 'package:lettutor/constants/routes.dart';

class TutorDetailView extends StatefulWidget {
  const TutorDetailView({Key? key}) : super(key: key);

  @override
  State<TutorDetailView> createState() => _TutorDetailViewState();
}

class _TutorDetailViewState extends State<TutorDetailView> {
  final teacher = teachers[0];
  bool isFavorite = false;

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
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.blue,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color: isFavorite ? Colors.red : Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.review);
                    },
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
                    onPressed: () async {
                      await showReportDialog(context);
                    },
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
            Text('Languages', style: Theme.of(context).textTheme.headline3),
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
            Text('Specialties', style: Theme.of(context).textTheme.headline3),
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
            Text('Suggested Courses', style: Theme.of(context).textTheme.headline3),
            ...courses.map((course) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        course.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.courseDetail);
                          },
                          child: const Text('View'))
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            Text('Interests', style: Theme.of(context).textTheme.headline3),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 8),
              child: Text('I loved the weather, the scenery and the '
                  'laid-back lifestyle of the locals.'),
            ),
            const SizedBox(height: 12),
            Text('Teaching Experiences', style: Theme.of(context).textTheme.headline3),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 8),
              child: Text('I have more than 10 years of teaching english experience'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: OutlinedButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(0),
                    padding: const EdgeInsets.all(8),
                    side: const BorderSide(color: Colors.blue, width: 1.5)),
                onPressed: () async {
                  final selectedDate = await bookLearningDate(context);
                  if (mounted) {
                    await bookLearningHour(context, selectedDate!);
                  }
                  // Navigator.pushNamed(context, Routes.booking);
                },
                child: const Text(
                  'Book This Tutor',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<DateTime?> bookLearningDate(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  );
  return selectedDate ?? DateTime.now();
}

Future<void> bookLearningHour(BuildContext context, DateTime selectedDate) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 5,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Choose Your Time',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(24),
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 32,
                  childAspectRatio: 3,
                  children: List<Widget>.generate(
                    courseHours.length,
                    (index) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        final dialogResult = await showBookingConfirmDialog(context);
                        if (dialogResult) {
                          Navigator.of(context).pushNamed(
                            Routes.bookingDetail,
                            arguments: {
                              'selectedDate': selectedDate,
                              'selectedHour': courseHours[index],
                              'weekday': selectedDate.weekday
                            },
                          );
                        }
                      },
                      child: Text(
                        courseHours[index],
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> showBookingConfirmDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Book Tutor'),
        content: const Text('Are you sure to book this tutor at this time?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('YES')),
        ],
      );
    },
  ).then((value) => value ?? false);
}

Future<bool> showReportDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Report Tutor'),
        content: const Text('Are you sure to report this tutor?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('CANCEL')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('YES')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
