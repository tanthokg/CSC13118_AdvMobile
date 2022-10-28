import 'package:flutter/material.dart';
import 'package:todo_app/widgets/date_picker.dart';
import 'package:todo_app/widgets/time_picker.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var _setReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () {},
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
            const TextField(
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
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
              children: const [
                Expanded(flex: 2, child: DatePicker()),
                SizedBox(width: 16),
                Expanded(flex: 1, child: TimePicker()),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _setReminder,
                  onChanged: (value) {
                    setState(() {
                      _setReminder = !_setReminder;
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
