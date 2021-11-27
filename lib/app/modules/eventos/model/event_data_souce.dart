import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<EventoModel> appointments) {
    this.appointments = appointments;
  }

  EventoModel getEvento(int index) => appointments![index] as EventoModel;

  @override
  String getData(int index) => getEvento(index).dia;

  @override
  double getValor(int index) => getEvento(index).valor;

  @override
  String getTipo(int index) => getEvento(index).tipo;

  @override
  String getFormaPagamento(int index) => getEvento(index).formaPagamento;

  @override
  String getNomeCliente(int index) => getEvento(index).nomeCliente;

  @override
  String getContatoCliente(int index) => getEvento(index).contatoCliente;

  @override
  bool getEntradaPago(int index) => getEvento(index).entradaPago;

  @override
  Color getColor(int index) => getEvento(index).color;
}
