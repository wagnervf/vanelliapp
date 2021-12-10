import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
        body: buildBody(),
        bottomNavigationBar: BottomNavigationBarCustom(),
      ),
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          BarChart(BarChartData(
              borderData: FlBorderData(
                  border: Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(width: 1),
                bottom: BorderSide(width: 1),
              )),
              groupsSpace: 10,
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(y: 10, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(y: 9, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(y: 4, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(y: 2, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(y: 13, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 6, barRods: [
                  BarChartRodData(y: 17, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 7, barRods: [
                  BarChartRodData(y: 19, width: 15, colors: [Colors.amber]),
                ]),
                BarChartGroupData(x: 8, barRods: [
                  BarChartRodData(y: 21, width: 15, colors: [Colors.amber]),
                ]),
              ]))
        ],
      ),
    );
  }
}
