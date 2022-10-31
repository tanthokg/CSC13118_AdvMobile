import 'package:flutter/material.dart';
import 'package:todo_app/constants/dummy_data.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/widgets/task_card.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  List<Task> _fetchUpcomingTasks() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    var tasks = _fetchUpcomingTasks();

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
