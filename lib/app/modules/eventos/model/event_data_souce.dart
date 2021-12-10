import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
