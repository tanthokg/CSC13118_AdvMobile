import 'package:flutter/material.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/services/task_dao.dart';
import 'package:todo_app/widgets/task_card.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  List<Task> todayTasks = [];
  bool isLoading = false;

  Future<void> _fetchTodayTasks() async {
    setState(() {
      isLoading = true;
    });

    final allTasks = await TaskDAO.instance.readAllTasks();
    final today = DateTime.now();

    todayTasks.clear();
    for (var task in allTasks) {
      if (task.dueTime?.year == today.year &&
          task.dueTime?.month == today.month &&
          task.dueTime?.day == today.day) {
        todayTasks.add(task);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTodayTasks();
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
            child: todayTasks.isNotEmpty
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _fetchTodayTasks();
                            });
                          },
                          child: const Text('Refresh'),
                        ),
                      ),
                      ...todayTasks
                          .map(
                            (task) => TaskCard(
                              task: task,
                              onCompleteChecked: (value) async {
                                await TaskDAO.instance.deleteTaskById(task.id!);
                                setState(() {
                                  _fetchTodayTasks();
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
                              _fetchTodayTasks();
                            });
                          },
                          child: const Text('Refresh'),
                        ),
                      ),
                      const Text('You have no task for today')
                    ],
                  ),
          );
  }
}
