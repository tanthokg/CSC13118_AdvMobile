import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String date = 'dd/MM/yyyy';

  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (selectedDate != null) {
      setState(() {
        date = selectedDate.toString().substring(0, 11);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        // width: 160,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: date == 'dd/MM/yyyy' ? Colors.grey[500]! : Colors.deepOrange,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Text(
          date,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: date == 'dd/MM/yyyy' ? FontWeight.normal : FontWeight.w500,
            letterSpacing: 1.0,
            color: date == 'dd/MM/yyyy' ? Colors.grey[500] : Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
