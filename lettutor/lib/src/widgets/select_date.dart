import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  final String initialValue;
  final Function(String newValue) onChanged;

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  String _selectedDate = '';

  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950, 1, 1),
      lastDate: DateTime(2050),
    );
    if (selectedDate != null) {
      _selectedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      widget.onChanged(_selectedDate);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
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
          border: Border.all(width: 2, color: Colors.grey[400]!),
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
