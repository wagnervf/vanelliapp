import 'package:flutter/material.dart';
import 'package:vanelliapp/app/components/bar_chart_widget.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';

class EventoRelatorios extends StatefulWidget {
  const EventoRelatorios({Key? key}) : super(key: key);

  @override
  _EventoRelatoriosState createState() => _EventoRelatoriosState();
}

class _EventoRelatoriosState extends State<EventoRelatorios> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        primary: true,
        body: buildBody(context),
        bottomNavigationBar: BottomNavigationBarCustom(),
      ),
    );
  }

  SingleChildScrollView buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          BarChartEidget(),
        ],
      ),
    );
  }
}
