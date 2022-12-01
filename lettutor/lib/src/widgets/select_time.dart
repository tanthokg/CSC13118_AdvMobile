import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  String time = 'hh:mm';

  void _selectTime(BuildContext context) async {
    final dateTime = DateTime.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: dateTime.hour,
        minute: dateTime.minute,
      ),
    );
    if (pickedTime != null) {
      final hour = pickedTime.hour.toString().padLeft(2, '0');
      final minute = pickedTime.minute.toString().padLeft(2, '0');
      setState(() {
        time = '$hour:$minute';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        width: 120,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: time == 'hh:mm' ? Colors.grey[400]! : Colors.black54,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: time == 'hh:mm' ? FontWeight.normal : FontWeight.w500,
            letterSpacing: 1.0,
            color: time == 'hh:mm' ? Colors.grey[400] : Colors.black54,
          ),
        ),
      ),
    );
  }
}
