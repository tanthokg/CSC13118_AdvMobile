import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.teacherDetail);
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/tutor/keegan-avatar.png'),
                    radius: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.teacherDetail);
                        },
                        child: Text(
                          'Keegan',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text('2022-10-20    10:00 - 10:55')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('No Requests For Lessons'),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text("Tutor haven't reviewed yet"),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: () async {
                      final dialogResult = await showReportDialog(context);
                    },
                    child: const Text(
                      'Report',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.writeReview);
                    },
                    child: const Text(
                      'Add A Review',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> showReportDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Report Lesson'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/tutor/keegan-avatar.png'),
                    radius: 32,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keegan',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: 4),
                        const Text('2022-10-20    10:00 - 10:55')
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Please tell us what went wrong',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 8),
              TextField(
                minLines: 3,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Additional Notes',
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
