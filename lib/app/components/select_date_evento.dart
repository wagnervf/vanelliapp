import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class SelectDateEvento extends StatefulWidget {
  const SelectDateEvento({Key? key}) : super(key: key);

  @override
  _SelectDateEventoState createState() => _SelectDateEventoState();
}

class _SelectDateEventoState extends State<SelectDateEvento> {
  final EventoController _controller = Get.put(EventoController());
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    _carregaDiaSelecionado();
  }

  void _carregaDiaSelecionado() {
    print('_carregaDiaSelecionado: ${_controller.diaSelecionado.toString()}');

    setState(() {
      selectedDate = DateTime.parse(_controller.diaSelecionado.toString());
    });
  }

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
    if (picked != null && picked != selectedDate)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedDate = picked;
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  String _dateFormat(data) {
    return DateFormat("dd/MM/yyyy", 'pt_Br').format(data);
  }

  void _clearDate() {
    _controller.limparDia();
    _carregaDiaSelecionado();

    // Get.to(() => EventoAdd());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Data'),
      leading: const Icon(
        Icons.date_range,
        color: kPrimaryColor,
      ),
      dense: true,
      visualDensity: VisualDensity.comfortable,
      subtitle: Text(
        _dateFormat(selectedDate),
        style: textStyle(),
      ),
      trailing: CloseButton(
        onPressed: _clearDate,
      ),
      onTap: () => _selectDate(context),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: kPrimaryColor,
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
    );
  }
}
