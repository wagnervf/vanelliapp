import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_add.dart';
import 'package:vanelliapp/app/theme.dart';

class CalendarViewPage extends StatefulWidget {
  const CalendarViewPage({Key? key}) : super(key: key);

  @override
  State<CalendarViewPage> createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  final EventoController _controller = Get.put(EventoController());
  late bool showEvento = false;
  late CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    setState(() {});
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  loadDataEventos() {
    return _controller.listaAppointments;
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
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Obx(
              () => Visibility(
                visible: _controller.buscando.value,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
                replacement: Column(
                  children: [
                    builCalendario(),
                    listEvento(),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: buttonAddEvento(),
        ),
      ),
    );
  }

  Container builCalendario() {
    return Container(
      // color: Colors.cyan,
      height: MediaQuery.of(context).size.height * .55,
      width: double.infinity,

      alignment: Alignment.topCenter,
      child: SfCalendar(
        controller: _calendarController,
        dataSource: loadDataEventos(),
        view: CalendarView.month,
        monthCellBuilder: (context, details) {
          return details.appointments.isEmpty
              ? cellNormal(details)
              : cellAgendado(details);
        },
        backgroundColor: Colors.transparent,
        firstDayOfWeek: 1,
        todayHighlightColor: Colors.deepOrange,
        headerStyle: calendarHeader(),
        initialDisplayDate: DateTime.now(),
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.grey[200],
        headerHeight: 50,
        viewHeaderHeight: 60,
        viewHeaderStyle: headerDiaSemana(),
        monthViewSettings: configMes(),
        showDatePickerButton: true,
        onTap: (CalendarTapDetails details) {
          _clickDate(details);
        },
      ),
    );
  }

  void _clickDate(details) {
    _controller.selecionarDiaEvento(details.date);

    if (details.appointments.isEmpty) {
      setState(() {
        showEvento = false;
      });
      return;
    }

    setState(() {
      showEvento = true;
    });
  }

  Visibility listEvento() {
    return Visibility(
        visible: showEvento,
        replacement: Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.all(12.0),
          color: Colors.grey[100],
          child: Text('Não há eventos!'),
        ),
        child: Container(
          width: double.infinity,
          child: ListTile(
            contentPadding: EdgeInsets.all(8.0),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '06\nTER',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            title: Container(
              height: 60,
              child: Card(
                elevation: 5,
                shape: Border(left: BorderSide(color: Colors.red, width: 5)),
                child: Column(
                  children: [
                    Text('Não há eventos!'),
                    Text('Não há eventos!'),
                    Text('Não há eventos!'),
                  ],
                ),
              ),
            ),
          ),
        ));
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
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }

  Container cellNormal(MonthCellDetails details) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.grey.shade200,
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
      // agendaViewHeight: 70,
      dayFormat: 'EEE',
      numberOfWeeksInView: 6,

      appointmentDisplayCount: 1,
      monthCellStyle: MonthCellStyle(
        trailingDatesTextStyle: TextStyle(color: Colors.purple),
        leadingDatesBackgroundColor: Colors.red,
        trailingDatesBackgroundColor: Colors.amber,
      ),

      appointmentDisplayMode: MonthAppointmentDisplayMode.none,
      showAgenda: false,
      // navigationDirection: MonthNavigationDirection.horizontal,
    );
  }

  ViewHeaderStyle headerDiaSemana() {
    return const ViewHeaderStyle(
      backgroundColor: Colors.transparent,
      dateTextStyle: TextStyle(
        color: Colors.purpleAccent,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: TextStyle(
        color: kPrimaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  FloatingActionButton buttonAddEvento() {
    return FloatingActionButton.extended(
      onPressed: () {
        print(_controller.diaSelecionado);
        if (_controller.diaSelecionado == "") {
          _controller.selecionarDiaEvento(DateTime.now());
        }

        Get.to(() => EventoAdd());
      },
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
}

//https://www.youtube.com/watch?v=TDerNqLEpPE

//https://www.youtube.com/watch?v=LoDtxRkGDTw
