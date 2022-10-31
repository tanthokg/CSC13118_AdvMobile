import 'package:flutter/material.dart';
import 'package:todo_app/constants/dummy_data.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/widgets/task_card.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  List<Task> _fetchTodayTasks() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    var tasks = _fetchTodayTasks();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: tasks
            .map(
              (task) => TaskCard(
                task: task,
                onCompleteChecked: (value) {
                  setState(() {
                    tasks.remove(task);
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
