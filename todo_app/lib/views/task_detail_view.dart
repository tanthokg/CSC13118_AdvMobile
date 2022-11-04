import 'package:flutter/material.dart';
import 'package:todo_app/entities/task.dart';

class TaskDetailView extends StatefulWidget {
  const TaskDetailView({Key? key}) : super(key: key);

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  final _nameController = TextEditingController();
  final _desController = TextEditingController();

  bool _isModified = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)?.settings.arguments as Task;
    print(task.name + task.description);
    _nameController.text = task.name;
    _desController.text = task.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          TextButton(
            onPressed: _isModified ? () {} : null,
            child: const Text('Save'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _desController,
              minLines: 2,
              maxLines: 5,
              decoration: const InputDecoration(
                label: Text('Description'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
