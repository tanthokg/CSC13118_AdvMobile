import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/entities/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.task,
    required this.onCompleteChecked,
  }) : super(key: key);

  final Task task;
  final Function(bool?) onCompleteChecked;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: onCompleteChecked,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.id.toString()),
              Text(task.name),
              Text(task.dueTime != null ? DateFormat.yMMMd().format(task.dueTime!) : ''),
            ],
          ),
        ],
      ),
    );
  }
}
