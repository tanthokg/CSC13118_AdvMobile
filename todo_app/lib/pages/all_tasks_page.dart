import 'package:flutter/material.dart';
import 'package:todo_app/constants/dummy_data.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/services/task_dao.dart';
import 'package:todo_app/widgets/task_card.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  late List<Task> tasks;
  bool isLoading = false;

  Future<void> _fetchAllTasks() async {
    setState(() {
      isLoading = true;
    });
    tasks = await TaskDAO.instance.readAllTasks();
    print(tasks);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator(
      color: Colors.deepOrange,
    ) : SingleChildScrollView(
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
