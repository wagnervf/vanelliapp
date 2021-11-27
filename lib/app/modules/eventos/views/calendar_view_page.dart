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
  const CalendarViewPage({Key? key}) : super(key: key);

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  final EventoController _controller = Get.find();
  //late List<EventoModel> eventosSalvo = _controller.eventos;

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
            child: builCalendario(),
          ),
        ),
        floatingActionButton: buttonAddEvento(),
      ),
    );
  }

  SfCalendar builCalendario() {
    return SfCalendar(
      dataSource: EventDataSource(_controller.eventos),
      view: CalendarView.month,
      headerStyle: calendarHeader(),
      initialDisplayDate: DateTime.now(),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.grey[200],
      allowViewNavigation: false,
      headerHeight: 50,
      viewHeaderHeight: 40,
      viewHeaderStyle: headerDiaSemana(),
      monthViewSettings: configMes(),
      appointmentTextStyle: TextStyle(
          color: Colors.amber,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto'),
      showDatePickerButton: true,
      onTap: (CalendarTapDetails details) {
        _clickDate(details);
      },
    );
  }

  MonthViewSettings configMes() {
    return const MonthViewSettings(
        dayFormat: 'EEE',
        numberOfWeeksInView: 6,
        appointmentDisplayCount: 2,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: true,
        navigationDirection: MonthNavigationDirection.horizontal);
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

  void _clickDate(CalendarTapDetails details) {
    _controller.selecionarDiaEvento(details.date);
    // Get.to(() => EventoAdd());
  }
}

// class MeetingDataSource extends CalendarDataSource {
//  MeetingDataSource(List<_Meeting> source) {
//    appointments = source;
//  }

//  @override
//  DateTime getStartTime(int index) {
//    return appointments![index].from;
//  }

//  @override
//  DateTime getEndTime(int index) {
//    return appointments![index].to;
//  }

//  @override
//  Color getColor(int index) {
//    return appointments![index].background;
//  }

//  @override
//  String getEndTimeZone(int index) {
//    return appointments![index].toZone;
//  }

//  @override
//  List<DateTime> getRecurrenceExceptionDates(int index) {
//    return appointments![index].exceptionDates;
//  }

//  @override
//  String getRecurrenceRule(int index) {
//    return appointments![index].recurrenceRule;
//  }

//  @override
//  String getStartTimeZone(int index) {
//    return appointments![index].fromZone;
//  }

//  @override
//  String getSubject(int index) {
//    return appointments![index].title;
//  }

//  @override
//  bool isAllDay(int index) {
//    return appointments![index].isAllDay;
//  }
// }

// class _Meeting {
//  _Meeting(
//      {required this.from,
//      required this.to,
//      this.title='',
//      this.isAllDay=false,
//      required this.background,
//      this.fromZone='',
//      this.toZone='',
//      this.exceptionDates,
//      this.recurrenceRule=''});
//  DateTime from;
//  DateTime to;
//  String title;
//  bool isAllDay;
//  Color background;
//  String fromZone;
//  String toZone;
//  String recurrenceRule;
//  List<DateTime>? exceptionDates;
// }

// final DateTime date = DateTime.now();
//  MeetingDataSource _getCalendarDataSource() {
//    List<_Meeting> appointments = <_Meeting>[];
//    appointments.add(_Meeting(
//     from: date,
//     to: date.add(const Duration(hours: 1)),
//     title: 'General Meeting',
//     isAllDay: false,
//     background: Colors.red,
//     fromZone: '',
//     toZone: '',
//     recurrenceRule: '',
//     exceptionDates: null
//  ));

//    return MeetingDataSource(appointments);
//  }

//https://www.youtube.com/watch?v=LoDtxRkGDTw