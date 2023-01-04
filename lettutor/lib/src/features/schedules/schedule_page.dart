import 'package:flutter/material.dart';

import 'history/views/history_view.dart';
import 'upcoming/views/upcoming_view.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Upcoming',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.history_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'History',
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  UpcomingView(),
                  HistoryView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
