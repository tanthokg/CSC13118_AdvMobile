import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
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
        width: 160,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey[400]!
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          date,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: date == 'dd/MM/yyyy' ? FontWeight.normal : FontWeight.w500,
            letterSpacing: 1.0,
            color: date == 'dd/MM/yyyy' ? Colors.grey[400] : Colors.black54,
          ),
        ),
      ),
    );
  }
}
