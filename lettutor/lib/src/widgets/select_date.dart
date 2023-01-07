import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key, required this.date}) : super(key: key);
  
  final String date;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  String _selectedDate = '';

  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate.toString().substring(0, 11);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
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
          _selectedDate,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: _selectedDate == 'dd/MM/yyyy' ? FontWeight.normal : FontWeight.w500,
            letterSpacing: 1.0,
            color: _selectedDate == 'dd/MM/yyyy' ? Colors.grey[400] : Colors.black54,
          ),
        ),
      ),
    );
  }
}
