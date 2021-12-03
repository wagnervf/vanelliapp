import 'dart:convert';

import 'package:flutter/material.dart';

class EventoModel {
  //final String dia;
  final int id;
  final int dia;
  final int mes;
  final int ano;
  final double valor;
  final String tipo;
  final String formaPagamento;
  final String nomeCliente;
  final String contatoCliente;
  final bool reservaPago;
  final bool totalPago;

  final String dataCadastro;
  final String idUsuario;

  final bool isAllDay;
  final String diaCompleto;

  EventoModel({
    required this.id,
    required this.dia,
    required this.mes,
    required this.ano,
    required this.valor,
    required this.tipo,
    required this.formaPagamento,
    required this.nomeCliente,
    required this.contatoCliente,
    required this.reservaPago,
    required this.totalPago,
    required this.dataCadastro,
    required this.idUsuario,
    required this.isAllDay,
    required this.diaCompleto,
  });

  // final String

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dia': dia,
      'mes': mes,
      'ano': ano,
      'valor': valor,
      'tipo': tipo,
      'formaPagamento': formaPagamento,
      'nomeCliente': nomeCliente,
      'contatoCliente': contatoCliente,
      'reservaPago': reservaPago,
      'totalPago': totalPago,
      'dataCadastro': dataCadastro,
      'idUsuario': idUsuario,
      'isAllDay': isAllDay,
      'diaCompleto': diaCompleto,
    };
  }

  factory EventoModel.fromMap(Map<String, dynamic> map) {
    return EventoModel(
      id: map['id'],
      dia: map['dia'],
      mes: map['mes'],
      ano: map['ano'],
      valor: map['valor'],
      tipo: map['tipo'],
      formaPagamento: map['formaPagamento'],
      nomeCliente: map['nomeCliente'],
      contatoCliente: map['contatoCliente'],
      reservaPago: map['reservaPago'],
      totalPago: map['totalPago'],
      dataCadastro: map['dataCadastro'],
      idUsuario: map['idUsuario'],
      isAllDay: map['isAllDay'],
      diaCompleto: map['diaCompleto'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventoModel.fromJson(String source) =>
      EventoModel.fromMap(json.decode(source));
}
