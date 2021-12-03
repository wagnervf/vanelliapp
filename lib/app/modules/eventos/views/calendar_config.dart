import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../theme.dart';

class CalendarConfig {
  static Container cellAgendado(MonthCellDetails details) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent[100],
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

  static Container cellNormal(MonthCellDetails details) {
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

  static MonthViewSettings configMes() {
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

  static ViewHeaderStyle headerDiaSemana() {
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

  static CalendarHeaderStyle calendarHeader() {
    return const CalendarHeaderStyle(
        backgroundColor: kPrimaryColor,
        textAlign: TextAlign.center,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
        ));
  }
}
