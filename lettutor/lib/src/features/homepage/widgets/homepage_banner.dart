import 'package:flutter/material.dart';
import 'package:lettutor/src/constants/routes.dart';
import 'package:lettutor/src/providers/auth_provider.dart';
import 'package:lettutor/src/services/user_service.dart';
import 'package:provider/provider.dart';

class HomepageBanner extends StatefulWidget {
  const HomepageBanner({Key? key}) : super(key: key);

  @override
  State<HomepageBanner> createState() => _HomepageBannerState();
}

class _HomepageBannerState extends State<HomepageBanner> {
  late Duration totalLessonTime;

  Future<void> _fetchTotalLessonTime(String token) async {
    final result = await UserService.getTotalLessonTime(token);

    setState(() {
      totalLessonTime = Duration(minutes: result);
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
      height: 176,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Upcoming Lesson',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '2022-10-21  18:30-18:55',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.videoCall);
                        },
                        child: const Text('Join', style: TextStyle(fontSize: 16)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 24),
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
