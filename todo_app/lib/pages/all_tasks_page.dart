import 'package:flutter/material.dart';
import 'package:todo_app/constants/dummy_data.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/widgets/task_card.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  List<Task> _fetchAllTasks() {
    return allTasks;
  }

  @override
  Widget build(BuildContext context) {
    var tasks = _fetchAllTasks();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: tasks
            .map((task) => TaskCard(
                  task: task,
                  onCompleteChecked: (value) {
                    setState(() {
                      tasks.remove(task);
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
