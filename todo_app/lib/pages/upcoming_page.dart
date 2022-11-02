import 'package:flutter/material.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/services/task_dao.dart';
import 'package:todo_app/widgets/task_card.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  List<Task> upcomingTasks = [];
  bool isLoading = false;

  Future<void> _fetchUpcomingTasks() async {
    setState(() {
      isLoading = true;
    });

    final allTasks = await TaskDAO.instance.readAllTasks();
    final today = DateTime.now();

    upcomingTasks.clear();
    for (var task in allTasks) {
      if (task.dueTime?.year != today.year ||
          task.dueTime?.month != today.month ||
          task.dueTime?.day != today.day) {
        upcomingTasks.add(task);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: upcomingTasks.isNotEmpty
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _fetchUpcomingTasks();
                            });
                          },
                          child: const Text('Refresh'),
                        ),
                      ),
                      ...upcomingTasks
                          .map(
                            (task) => TaskCard(
                              task: task,
                              onCompleteChecked: (value) async {
                                await TaskDAO.instance.deleteTaskById(task.id!);
                                setState(() {
                                  _fetchUpcomingTasks();
                                });
                              },
                            ),
                          )
                          .toList()
                    ],
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _fetchUpcomingTasks();
                            });
                          },
                          child: const Text('Refresh'),
                        ),
                      ),
                      const Text('You have no upcoming task')
                    ],
                  ),
          );
  }
}
