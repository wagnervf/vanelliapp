import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  /// Which holds the selected date
  /// Defaults to today's date.
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select booking date', // Can be used as title
      cancelText: 'Canlcelar',
      confirmText: 'Confirmar',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  String dateFormat(data) {
    return DateFormat("dd/MM/yyyy", 'pt_Br').format(data);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.date_range),
      title: Text(
        dateFormat(selectedDate),
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
