import 'package:flutter/material.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/services/task_dao.dart';
import 'package:todo_app/widgets/date_picker.dart';
import 'package:todo_app/widgets/time_picker.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var _setNoti = false;
  DateTime? _dueDate;
  final _nameController = TextEditingController();
  final _desController = TextEditingController();
  final errorText = 'This field is required!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () async {
                final task = Task(
                  name: _nameController.text,
                  description: _desController.text,
                  dueTime: _dueDate,
                  notification: _setNoti,
                  status: 'Not Done',
                  isTrashed: false,
                );
                await TaskDAO.instance.createTask(task);
                // print('${_nameController.text} ${_desController.text} ${DateTime.now()}');
              },
              child: const Text(
                'CREATE',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              minLines: 1,
              maxLines: 3,
              controller: _nameController,
              onChanged: (value) {
              },
              decoration: const InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              minLines: 2,
              maxLines: 5,
              controller: _desController,
              onChanged: (value) {
              },
              decoration: const InputDecoration(
                label: Text('Description (optional)'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Due Time',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(flex: 2, child: DatePicker(
                  onDateSelected: (value) {
                   setState(() {
                     _dueDate = value;
                   });
                  },
                )),
                const SizedBox(width: 16),
                const Expanded(flex: 1, child: TimePicker()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _setNoti,
                  onChanged: (value) {
                    setState(() {
                      _setNoti = !_setNoti;
                    });
                  },
                ),
                Text(
                  'Receive Notification (10 minutes early)',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
