import 'package:flutter/material.dart';
import 'package:lettutor/widgets/upcoming_card.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int count = 10;

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
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: List<Widget>.generate(
                        count,
                        (index) => const UpcomingCard(),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text('History'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
