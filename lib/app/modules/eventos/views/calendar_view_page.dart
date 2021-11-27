import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_data_souce.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_add.dart';
import 'package:vanelliapp/app/theme.dart';

class CalendarViewPage extends StatefulWidget {
  CalendarViewPage({Key? key}) : super(key: key);

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  final EventoController _controller = Get.find();
  late bool showEvento = false;
//  late Employee eventoSelecionado;

  @override
  void initState() {
    setState(() {
      //     eventoSelecionado;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            width: double.infinity,
            child: Column(
              children: [
                builCalendario(),
                Visibility(
                    visible: showEvento,
                    child: Container(
                      child: Card(
                        child: ListTile(
                          title: Text('eventoSelecionado.empName'),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        floatingActionButton: buttonAddEvento(),
      ),
    );
  }

  SfCalendar builCalendario() {
    return SfCalendar(
      //dataSource: EventDataSource(_controller.eventos),
      dataSource: _getCalendarDataSource(),
      view: CalendarView.month,
      monthCellBuilder: (context, details) {
        return details.appointments.isEmpty
            ? cellNormal(details)
            : cellAgendado(details);
      },
      headerStyle: calendarHeader(),
      initialDisplayDate: DateTime.now(),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.grey[200],
      allowViewNavigation: false,
      headerHeight: 50,
      viewHeaderHeight: 40,
      viewHeaderStyle: headerDiaSemana(),
      monthViewSettings: configMes(),
      showDatePickerButton: true,
      onTap: (CalendarTapDetails details) {
        _clickDate(details);
      },
      appointmentBuilder: (context, details) {
        final event = details.appointments.first;

        return Container(
          width: double.infinity,
          height: 200,
          color: Colors.teal,
          child: Text(
            event.notes,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto'),
          ),
        );
      },
    );
  }

  void _clickDate(CalendarTapDetails details) {
    _controller.selecionarDiaEvento(details.date);
    print(details.appointments);
    if (details.appointments == []) {
      setState(() {
        showEvento = false;
      });
      return;
    }

    print('antes: $showEvento');

    setState(() {
      showEvento = true;
      final evento = details.appointments!.first;
      print('showEvento: $showEvento');

      // eventoSelecionado.empAge = evento.id.empAge;
      // eventoSelecionado.empName = evento.id.empName;
      // eventoSelecionado.empSalary = evento.id.empSalary;
    });

    // Get.to(() => EventoAdd());
  }
}

Container cellAgendado(MonthCellDetails details) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.redAccent[200],
      border: Border.all(
        color: Colors.grey.shade100,
        width: 0.5,
      ),
    ),
    child: Center(
      child: Text(
        details.date.day.toString(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
      ),
    ),
  );
}

Container cellNormal(MonthCellDetails details) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey.shade100,
        width: 0.5,
      ),
    ),
    child: Center(
      child: Text(
        details.date.day.toString(),
        style: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 20.0),
      ),
    ),
  );
}

MonthViewSettings configMes() {
  return const MonthViewSettings(
    showTrailingAndLeadingDates: false,
    agendaViewHeight: 80,
    dayFormat: 'EEE',
    numberOfWeeksInView: 6,
    appointmentDisplayCount: 1,
    appointmentDisplayMode: MonthAppointmentDisplayMode.none,
    showAgenda: false,
    // navigationDirection: MonthNavigationDirection.horizontal,
  );
}

ViewHeaderStyle headerDiaSemana() {
  return const ViewHeaderStyle(
    backgroundColor: Colors.transparent,
    dayTextStyle: TextStyle(
      color: kPrimaryColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
  );
}

FloatingActionButton buttonAddEvento() {
  return FloatingActionButton.extended(
    onPressed: () => Get.to(() => const EventoAdd()),
    label: const Text("Novo Evento"),
    icon: const Icon(Icons.add),
  );
}

CalendarHeaderStyle calendarHeader() {
  return const CalendarHeaderStyle(
      backgroundColor: kPrimaryColor,
      textAlign: TextAlign.center,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 22.0,
      ));
}

_AppointmentDataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];

  appointments.add(Appointment(
      startTime: DateTime(2021, 11, 16),
      endTime: DateTime(2021, 11, 16),
      subject: 'Occurs daily',
      color: Colors.red,
      isAllDay: true,
      notes: 'Wagner',
      id: Employee(empName: "wagner", empAge: 25, empSalary: 3600)));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class Employee {
  String empName;
  int empAge;
  int empSalary;
  Employee({
    required this.empName,
    required this.empAge,
    required this.empSalary,
  });

  @override
  String toString() =>
      'Employee(empName: $empName, empAge: $empAge, empSalary: $empSalary)';
}

//https://www.youtube.com/watch?v=LoDtxRkGDTw