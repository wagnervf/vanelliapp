import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_details.dart';
import 'package:vanelliapp/app/theme.dart';
import 'calendar_config.dart';
import 'evento_add.dart';

class EventoView extends StatefulWidget {
  const EventoView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventoView> {
  final EventoController _controller = Get.put(EventoController());
  late bool showEvento = false;
  late CalendarController _calendarController;
  late List<EventoModel> listAppointmentDia = [];
  late DateTime dataSetadoCalendario;

  @override
  void initState() {
    verificaEventoDoDia();
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
          backgroundColor: Colors.white,
          primary: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildCalendario(),
                showEvento
                    ? cardEventoAtual(listAppointmentDia.first)
                    : CalendarConfig.naoHaEventos(),
                buttonRefresh(),
              ],
            ),
          ),
          floatingActionButton: buttonAddEvento(),
          bottomNavigationBar: BottomNavigationBarCustom(),
        ),
      ),
    );
  }

  Container buttonRefresh() {
    return Container(
      alignment: Alignment.bottomLeft,
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 12, top: 34),
      child: IconButton(
        color: kTextColor,
        onPressed: () {
          print('RefreshIndicator');
          print(dataSetadoCalendario);
          _controller.getEventoCollection(
            mesV: dataSetadoCalendario,
            anoV: dataSetadoCalendario,
          );
          setState(() {});
        },
        icon: const Icon(Icons.refresh),
      ),
    );
  }

  buildCalendario() {
    return Container(
      height: MediaQuery.of(context).size.height * .65,
      width: double.infinity,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.zero,
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
          headerStyle: CalendarConfig.calendarHeader(),
          initialDisplayDate: DateTime.now(),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.grey[200],
          headerHeight: 50,
          viewHeaderHeight: 60,
          viewNavigationMode: ViewNavigationMode.none,
          viewHeaderStyle: CalendarConfig.headerDiaSemana(),
          monthViewSettings: CalendarConfig.configMes(),
          showDatePickerButton: true,
          showNavigationArrow: false,
          showCurrentTimeIndicator: true,
          onTap: (CalendarTapDetails details) {
            if (details.appointments != null) {
              _clickDate(details);
            }
          },
          onViewChanged: (ViewChangedDetails details) {
            List<DateTime> dates = details.visibleDates;
            dataSetadoCalendario = dates[0];
            _controller.getEventoCollection(mesV: dates[0], anoV: dates[0]);
            showEvento = false;
            //setState(() {});
          },
        ),
      ),
    );
  }

  void verificaEventoDoDia() {
    List? value = _controller.checkEventoDoDia();

    if (value!.isEmpty) {
      showEvento = false;
      setState(() {});
      return;
    }
    setDataList(value[0].id);
  }

  void _clickDate(CalendarTapDetails details) {
    _controller.selecionarDiaEvento(details.date);

    if (details.appointments!.isNotEmpty) {
      if (details.appointments != null) {
        setDataList(details.appointments![0].id);
      }

      return;
    } else {
      showEvento = false;
      setState(() {});
    }
  }

  void setDataList(EventoModel value) {
    listAppointmentDia.clear();
    listAppointmentDia.add(value);
    showEvento = true;
    setState(() {});
  }

  cardEventoAtual(EventoModel doc) {
    return InkWell(
      child: Componentsutils.buildBodyListRecentes(doc),
      onTap: () => Get.to(
        const EventoDetails(),
        arguments: doc,
      ),
    );
  }

  // Componentsutils.buildBodyListRecentes(
  //               _controller.todosEventos![index],
  //             );

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
