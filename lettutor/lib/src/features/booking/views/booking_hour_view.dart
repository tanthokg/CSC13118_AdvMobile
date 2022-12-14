import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/models/schedule/schedule.dart';

class BookingHourView extends StatelessWidget {
  const BookingHourView({
    Key? key,
    required this.schedules,
    required this.timestamp,
  }) : super(key: key);

  final List<Schedule> schedules;
  final int timestamp;

  @override
  Widget build(BuildContext context) {
    final pickedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);

    final validSchedules = schedules.where((schedule) {
      if (schedule.startTimestamp == null) return false;
      // if (schedule.isBooked ?? false) return false;

      final date = DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
      if (date.day == pickedDate.day &&
          date.month == pickedDate.month &&
          date.year == pickedDate.year) {
        return true;
      }
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: const Text('Choose learning time'),
      ),
      body: Column(
        children: [
          Text(
            'On ${DateFormat.yMMMMEEEEd().format(pickedDate)}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(24),
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 32,
              childAspectRatio: 3,
              children: List<Widget>.generate(
                validSchedules.length,
                (index) {
                  final start = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                      validSchedules[index].startTimestamp ?? 0));
                  final end = DateFormat('HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(validSchedules[index].endTimestamp ?? 0));

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                    ),
                    onPressed: validSchedules[index].isBooked ?? true ? null : () {
                      Navigator.pushNamed(context, Routes.bookingDetail);
                    },
                    child: Text(
                      '$start - $end',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
