import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constants/routes.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.detail, arguments: task);
          },
          child: Row(
            children: [
              Checkbox(
                value: false,
                onChanged: onCompleteChecked,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: Theme.of(context).textTheme.headline2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  task.dueTime != null
                      ? Text(DateFormat.yMMMd().format(task.dueTime!))
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
