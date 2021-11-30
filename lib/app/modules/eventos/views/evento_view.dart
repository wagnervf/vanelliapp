import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/views/calendar_view_page.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoView extends StatefulWidget {
  const EventoView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventoView> {
  // ignore: unused_field
  final EventoController _controller = Get.put(EventoController());
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      backgroundColor: kPrimaryColor,
      body: const CalendarViewPage(),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  Text title() {
    return const Text(
      'Calendário de Eventos',
      style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.normal),
      textAlign: TextAlign.center,
    );
  }
}
