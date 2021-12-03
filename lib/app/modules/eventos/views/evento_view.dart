import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';

import 'package:vanelliapp/app/theme.dart';

import 'calendar_config.dart';
import 'evento_add.dart';

class EventoView extends StatefulWidget {
  const EventoView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventoView> {
  // ignore: unused_field
  // final EventoController _controller = Get.put(EventoController());
  // @override
  // void initState() {
  //   setState(() {});
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     primary: true,
  //     backgroundColor: kPrimaryColor,
  //     body: const CalendarViewPage(),
  //     bottomNavigationBar: BottomNavigationBarCustom(),
  //   );
  // }

  final EventoController _controller = Get.put(EventoController());
  late bool showEvento;
  late CalendarController _calendarController;
  late List<EventoModel> listAppointmentDia = [];

  @override
  void initState() {
    setState(() {
      showEvento = false;
    });

    listAppointmentDia = [];
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
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
          primary: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildCalendario(),
                showEvento
                    ? Componentsutils.buildBodyListRecentes(
                        listAppointmentDia.first)
                    : naoHaEventos(),
              ],
            ),
          ),
          floatingActionButton: buttonAddEvento(),
          bottomNavigationBar: BottomNavigationBarCustom(),
        ),
      ),
    );
  }

  Container buildCalendario() {
    return Container(
        // color: Colors.cyan,
        height: MediaQuery.of(context).size.height * .55,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Obx(
          () => SfCalendar(
            controller: _calendarController,
            dataSource: _controller.listaAppointments,
            view: CalendarView.month,
            monthCellBuilder: (context, details) {
              return details.appointments.isEmpty
                  ? CalendarConfig.cellNormal(details)
                  : CalendarConfig.cellAgendado(details);
            },
            backgroundColor: Colors.transparent,
            firstDayOfWeek: 1,
            todayHighlightColor: Colors.deepOrange,
            headerStyle: CalendarConfig.calendarHeader(),
            initialDisplayDate: DateTime.now(),
            initialSelectedDate: DateTime.now(),
            cellBorderColor: Colors.grey[200],
            headerHeight: 50,
            viewHeaderHeight: 60,
            viewHeaderStyle: CalendarConfig.headerDiaSemana(),
            monthViewSettings: CalendarConfig.configMes(),
            showDatePickerButton: true,
            onTap: (CalendarTapDetails details) {
              _clickDate(details);
            },
          ),
        ));
  }

  void _clickDate(CalendarTapDetails details) {
    _controller.selecionarDiaEvento(details.date);
    //_controller.getEventoCollection();
    //print(details.appointments);

    if (details.appointments!.isNotEmpty) {
      listAppointmentDia.clear();
      listAppointmentDia.add(details.appointments![0].id as EventoModel);
      setState(() {
        showEvento = true;
      });
      return;
    }

    setState(() {
      showEvento = false;
    });
  }

  Container naoHaEventos() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(12.0),
      color: Colors.grey[100],
      child: const Text('Não há evento nesse dia'),
    );
  }

  FloatingActionButton buttonAddEvento() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (_controller.diaSelecionado == "") {
          _controller.selecionarDiaEvento(DateTime.now());
        }

        Get.to(() => const EventoAdd());
      },
      label: const Text("Novo Evento"),
      icon: const Icon(Icons.add),
    );
  }
}
