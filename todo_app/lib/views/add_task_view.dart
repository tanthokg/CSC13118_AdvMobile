import 'package:flutter/material.dart';
import 'package:todo_app/entities/task.dart';
import 'package:todo_app/services/notification_service.dart';
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
  TimeOfDay? _dueTime;
  final _nameController = TextEditingController();
  final _desController = TextEditingController();
  bool _validateTaskName = false;
  bool _isDateTimeSelected = false;
  final _errorTaskNameEmpty = 'This field is required!';

  DateTime _mergeDateAndTime(DateTime date, TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;

    final result = date
        .add(Duration(hours: hour, minutes: minute))
        .subtract(const Duration(minutes: 10));
    return result;
  }

  @override
  void initState() {
    super.initState();
    NotificationService.init(initScheduled: true);
  }

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
                if (_setNoti && _dueDate != null && _dueTime != null) {
                  NotificationService.showScheduleNotification(
                    title: 'Schedule Title',
                    body: 'Schedule Body',
                    payload: 'Payload',
                    scheduledTime: _mergeDateAndTime(_dueDate!, _dueTime!),
                  );
                }
                // NotificationService.showNotification(
                //   title: 'Instant Title',
                //   body: 'Instant Body',
                //   payload: 'Payload',
                // );
                if (_validateTaskName) {
                  final task = Task(
                    name: _nameController.text,
                    description: _desController.text,
                    dueTime: _dueDate,
                    notification: _setNoti,
                    status: 'Not Done',
                    isTrashed: false,
                  );
                  await TaskDAO.instance.createTask(task);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
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
                if (value == '') {
                  setState(() {
                    _validateTaskName = false;
                  });
                } else {
                  setState(() {
                    _validateTaskName = true;
                  });
                }
              },
              decoration: InputDecoration(
                label: const Text('Name'),
                errorText: _validateTaskName ? null : _errorTaskNameEmpty,
                errorStyle: const TextStyle(fontSize: 14),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              minLines: 2,
              maxLines: 5,
              controller: _desController,
              onChanged: (value) {},
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
                Expanded(
                  flex: 2,
                  child: DatePicker(
                    onDateSelected: (value) {
                      setState(() {
                        _dueDate = value;
                        if (_dueTime != null) {
                          _isDateTimeSelected = true;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: TimePicker(
                    onTimeSelected: (value) {
                      setState(() {
                        _dueTime = value;
                        if (_dueDate != null) {
                          _isDateTimeSelected = true;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _setNoti,
                  onChanged: _dueDate == null || _dueTime == null
                      ? null
                      : (value) {
                          setState(() {
                            _setNoti = !_setNoti;
                            //_isDateTimeSelected = true;
                          });
                        },
                ),
                Text(
                  'Receive Notification (10 minutes early)',
                  style: Theme.of(context).textTheme.headline3,
                )
              ],
            ),
            _isDateTimeSelected ? SizedBox.shrink() : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'You must first select a date and time',
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
