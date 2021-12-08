import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_data_souce.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_details.dart';
import '../../../theme.dart';
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
          viewHeaderStyle: CalendarConfig.headerDiaSemana(),
          monthViewSettings: CalendarConfig.configMes(),
          showDatePickerButton: true,
          onTap: (CalendarTapDetails details) {
            _clickDate(details);
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
      setDataList(details.appointments![0].id);
      return;
    }

    showEvento = false;
    setState(() {});
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
      onTap: () => Get.to(const EventoDetails(), arguments: doc),
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
