import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/models/schedule/booking_info.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/user_service.dart';
import 'package:provider/provider.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader({Key? key}) : super(key: key);

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  late Duration totalLessonTime;
  late BookingInfo upcomingClass;

  Future<void> _fetchTotalLessonTime(String token) async {
    final total = await UserService.getTotalLessonTime(token);
    final upcoming = await UserService.getUpcomingLesson(token);

    setState(() {
      totalLessonTime = Duration(minutes: total);
      upcomingClass = upcoming;
      _isLoading = false;
    });
  }

  String _convertTotalLessonTime() {
    if (totalLessonTime.inMinutes == 0) {
      return 'You have not attended any class';
    }

    String result = 'Total Lesson Time:';

    final int hour = totalLessonTime.inHours;
    final int minute = totalLessonTime.inMinutes - hour * 60;
    result += hour > 0 ? ' $hour ${hour > 1 ? 'hours' : 'hour'}' : '';
    result += minute > 0 ? ' $minute ${minute > 1 ? 'minutes' : 'minute'}' : '';

    return result;
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (_isLoading && authProvider.token != null) {
      final String accessToken = authProvider.token?.access?.token as String;
      _fetchTotalLessonTime(accessToken);
    }

    return Container(
      color: Colors.blue[700],
      width: double.maxFinite,
      height: 208,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Upcoming Lesson',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Text(
                  '${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(upcomingClass.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} '
                  '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(upcomingClass.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} - '
                  '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(upcomingClass.scheduleDetailInfo!.endPeriodTimestamp ?? 0))}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.videoCall);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.ondemand_video_rounded),
                          SizedBox(width: 12),
                          Text('Enter Lesson Room', style: TextStyle(fontSize: 16)),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Text(
                    _convertTotalLessonTime(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
    );
  }
}
