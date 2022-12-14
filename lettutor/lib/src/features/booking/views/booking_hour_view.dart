import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/src/models/schedule/schedule.dart';

class BookingHourView extends StatelessWidget {
  const BookingHourView({Key? key, required this.schedule}) : super(key: key);

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.MMMEd().format(DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: Text(date),
      ),
    );
  }
}
