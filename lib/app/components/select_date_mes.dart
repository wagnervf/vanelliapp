import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class SelectDateMes extends StatefulWidget {
  const SelectDateMes({Key? key}) : super(key: key);

  @override
  _SelectDateMesState createState() => _SelectDateMesState();
}

class _SelectDateMesState extends State<SelectDateMes> {
  final EventoController _controller = Get.put(EventoController());
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    _carregaDia();
  }

  void _carregaDia() {
    setState(() {
      selectedDate = DateTime.now();
    });
  }

  _selectDate(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedDate,
      locale: const Locale("pt", "BR"),
    ).then((date) {
      if (date != null && date != selectedDate) {
        print('####$date#####');
        _controller.selecionarMesFiltro(date);
        setState(() {
          selectedDate = date;
        });
      }
    });
  }

  String _dateFormat(data) {
    return DateFormat("MMM", 'pt_Br').format(data).capitalizeFirst!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton.icon(
        onPressed: () => _selectDate(context),
        icon: const Icon(
          Icons.filter_alt,
          color: kPrimaryColor,
          size: 22,
        ),
        label: Text(
          _dateFormat(selectedDate),
          style: styleFilter(),
        ),
      ),
    );
  }

  TextStyle styleFilter() {
    return const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: kPrimaryColor);
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: kPrimaryColor,
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
    );
  }
}
