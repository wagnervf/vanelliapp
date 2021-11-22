import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/constants.dart';
import 'package:vanelliapp/app/modules/eventos/views/calendar_view_page.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoView extends StatefulWidget {
  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventoView> {
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
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  String dateFormat(data) {
    return DateFormat("dd/MM/yyyy", 'pt_Br').format(data);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.white,
            bottom: const TabBar(
              labelColor: kPrimaryColor,
              unselectedLabelColor: ksecondaryColor,
              labelPadding: EdgeInsets.zero,
              isScrollable: false,
              tabs: [
                Tab(
                  text: 'Calendário',
                  icon: Icon(Icons.date_range),
                ),
                Tab(
                  text: 'Todos Eventos',
                  icon: Icon(Icons.list_alt),
                ),
              ],
            ),
            centerTitle: true,
            title: const Text(
              'Eventos',
              style: TextStyle(
                  color: kPrimaryColor, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
          body: TabBarView(
            children: [
              CalendarViewPage(),
              centerDate(context),
            ],
          ),
          bottomNavigationBar: BottomNavigationBarCustom(),
        ),
      ),
    );
  }

  Center centerDate(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            dateFormat(selectedDate),
            //.split(' ')[0],
            style: const TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text(
              'Data',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}