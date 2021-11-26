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
  final EventoController _controller = Get.find();
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              width: double.infinity,
              child: SfCalendar(
                view: CalendarView.month,
                initialDisplayDate: DateTime.now(),
                initialSelectedDate: DateTime.now(),
                cellBorderColor: Colors.grey[200],
                allowViewNavigation: false,
                monthViewSettings: const MonthViewSettings(
                  agendaItemHeight: 14.0,
                  showAgenda: true,
                ),
                showDatePickerButton: true,
                onTap: (CalendarTapDetails details) {
                  _clickDate(details);
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.to(() => const EventoAdd()),
          label: const Text("Novo Evento"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _clickDate(CalendarTapDetails details) {
    _controller.selecionarDiaEvento(details.date);
    // Get.to(() => EventoAdd());
  }
}

//https://www.syncfusion.com/kb/12328/how-to-override-the-localization-in-the-flutter-calendar
