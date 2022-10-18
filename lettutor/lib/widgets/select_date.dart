import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime? date;

  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    setState(() {
      date = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        width: 160,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey[400]!,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          date == null ? 'dd/MM/yyyy' : date.toString().substring(0, 11),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
