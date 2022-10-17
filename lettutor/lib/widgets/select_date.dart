import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({
    Key? key,
    required this.setDate,
    this.date,
  }) : super(key: key);

  final Function(DateTime? date) setDate;
  final DateTime? date;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (selectedDate != null && selectedDate != widget.date) {
      widget.setDate(selectedDate);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 160,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: "select a day",
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );
  }
}
