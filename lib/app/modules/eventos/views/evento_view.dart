import 'package:flutter/material.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/modules/eventos/views/calendar_view_page.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoView extends StatefulWidget {
  const EventoView({Key? key}) : super(key: key);

  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: title(),
        elevation: 2.0,
      ),
      body: CalendarViewPage(),
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
