import 'package:flutter/material.dart';

class EventoModel {
  final String dia;
  final double valor;
  final String tipo;
  final String formaPagamento;
  final String nomeCliente;
  final String contatoCliente;
  final Color color;
  final bool entradaPago;
  // final String

  EventoModel({
    required this.dia,
    required this.valor,
    required this.tipo,
    required this.formaPagamento,
    required this.nomeCliente,
    required this.contatoCliente,
    this.color = Colors.teal,
    required this.entradaPago,
  });

  @override
  String toString() {
    return 'EventoModel( dia: $dia, valor: $valor, tipo: $tipo, formaPagamento: $formaPagamento, nomeCliente: $nomeCliente, contatoCliente: $contatoCliente, backgroundColor: $color, entradaPago: $entradaPago)';
  }
}
