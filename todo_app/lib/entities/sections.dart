import 'package:todo_app/pages/all_tasks_page.dart';
import 'package:todo_app/pages/today_page.dart';
import 'package:todo_app/pages/upcoming_page.dart';

enum Sections {
  allTasks,
  today,
  upcoming,
}

const titles = {
  Sections.allTasks: 'All Tasks',
  Sections.today: 'Today',
  Sections.upcoming: 'Upcoming',
};

var pages = {
  Sections.allTasks: const AllTasksPage(),
  Sections.today: const TodayPage(),
  Sections.upcoming: const UpcomingPage(),
};