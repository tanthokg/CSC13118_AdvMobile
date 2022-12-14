import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/dummy/dummy_data.dart';
import 'package:lettutor/src/features/booking/views/booking_hour_view.dart';
import 'package:lettutor/src/models/schedule/schedule.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/tutor_service.dart';
import 'package:provider/provider.dart';

class TutorSchedule extends StatefulWidget {
  const TutorSchedule({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<TutorSchedule> createState() => _TutorScheduleState();
}

class _TutorScheduleState extends State<TutorSchedule> {
  List<Schedule> schedules = [];

  bool _isLoading = true;

  Future<void> _fetchTutorSchedule(String token) async {
    List<Schedule> result = await TutorService.getTutorScheduleById(
      token: token,
      userId: widget.userId,
    );

    // Remove all learning dates before today
    result = result.where((schedule) {
      if (schedule.startTimestamp == null) return false;

      final now = DateTime.now();
      final start = DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
      return start.isAfter(now.subtract(const Duration(days: 1)));
    }).toList();

    // Sort learning date increasingly
    result.sort((s1, s2) {
      if (s1.startTimestamp == null || s2.startTimestamp == null) return 0;
      return s1.startTimestamp!.compareTo(s2.startTimestamp!);
    });

    // Remove duplicates learning dates
    schedules.clear();
    for (var schedule in result) {
      if (!schedules.any((element) {
        final date1 = DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp!);
        final date2 = DateTime.fromMillisecondsSinceEpoch(element.startTimestamp!);
        if (date1.day == date2.day && date1.month == date2.month && date1.year == date2.year) {
          return true;
        }
        return false;
      })) {
        schedules.add(schedule);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchTutorSchedule(accessToken);
    }

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 0),
                    child: Text(
                      'Choose Learning Date',
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
                        schedules.length,
                        (index) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[300],
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return BookingHourView(
                                  schedules: schedules,
                                  timestamp: schedules[index].startTimestamp!,
                                );
                              },
                            ));
                          },
                          child: Text(
                            DateFormat.MMMEd().format(DateTime.fromMillisecondsSinceEpoch(
                                schedules[index].startTimestamp ?? 0)),
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
  }
}

Future<DateTime?> _bookLearningDate(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
  return selectedDate ?? DateTime.now();
}

Future<void> _bookLearningHour(BuildContext context, DateTime selectedDate) async {
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
                padding: const EdgeInsets.only(top: 32, bottom: 8),
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
                        final dialogResult = await _showBookingConfirmDialog(context);
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

Future<bool> _showBookingConfirmDialog(BuildContext context) {
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
