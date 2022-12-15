import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key, required this.bookingInfo}) : super(key: key);

  final BookingInfo bookingInfo;

  String _convertClassTime() {
    String result = '';
    result += DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.startPeriodTimestamp ?? 0));
    result += ' - ';
    result += DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(
        bookingInfo.scheduleDetailInfo!.endPeriodTimestamp ?? 0));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      surfaceTintColor: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // const CircleAvatar(
                //   backgroundImage: AssetImage('assets/tutor/keegan-avatar.png'),
                //   radius: 32,
                // ),
                Container(
                  width: 72,
                  height: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar ?? '',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline_rounded,
                      size: 32,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name ??
                            'null name',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                            bookingInfo.scheduleDetailInfo!.startPeriodTimestamp ?? 0)),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _convertClassTime(),
                        style: const TextStyle(fontSize: 15),
                      ),
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
