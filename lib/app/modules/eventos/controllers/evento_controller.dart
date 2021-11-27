import 'dart:core';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';

class EventoController extends GetxController {
  //late DateTime _diaSelecionado = DateTime.obs;
  final Rx<DateTime> _diaSelecionado = DateTime.now().obs;
  final Rx<double> _valorEvento = 0.0.obs;
  final Rx<String> _tipoEvento = "".obs;
  final Rx<String> _descricaoEvento = "".obs;
  final Rx<bool> _entradaPago = true.obs;
  final Rx<String> _formaPagamentoEvento = "".obs;
  final Rx<String> _nomeClienteEvento = "".obs;
  final Rx<String> _contatoClienteEvento = "".obs;

  final _eventos = <EventoModel>[].obs;

  Rx<DateTime> get diaSelecionado => _diaSelecionado;
  get diaFomatado => DateFormat('dd/MM/yy').format(_diaSelecionado.value);
  get tipoEvento => _tipoEvento.value;
  get valorDoEvento => _valorEvento.value;
  get descricaoDoEvento => _descricaoEvento.value;
  get entradaPagoEvento => _entradaPago.value;
  get formaPagamentoEvento => _formaPagamentoEvento.value;
  get nomeClienteEvento => _nomeClienteEvento.value;
  get contatoClienteEvento => _contatoClienteEvento.value;

  List<EventoModel> get eventos => _eventos.toList();

  selecionarDiaEvento(value) {
    _diaSelecionado.value = value;
    _diaSelecionado.refresh();
  }

  limparDia() {
    _diaSelecionado.value = DateTime.now();
    _diaSelecionado.refresh();
  }

  setValorEvento(value) {
    _valorEvento.value = value;
    _valorEvento.refresh();
  }

  setTipoEvento(value) {
    _tipoEvento.value = value;
    _tipoEvento.refresh();
  }

  setDescricaoEvento(value) {
    _descricaoEvento.value = value;
    _descricaoEvento.refresh();
  }

  setEntradaPagoEvento(value) {
    _entradaPago.value = value;
    _entradaPago.refresh();
  }

  setFormaPagamentoEvento(value) {
    _formaPagamentoEvento.value = value;
    _formaPagamentoEvento.refresh();
  }

  setNomeClienteEvento(String nome) {
    _nomeClienteEvento.value = nome;
    _nomeClienteEvento.refresh();
  }

  setContatoClienteEvento(String contato) {
    _contatoClienteEvento.value = contato;
    _contatoClienteEvento.refresh();
  }

  setEventoModel() {
    final evento = EventoModel(
      dia: diaFomatado,
      valor: valorDoEvento,
      tipo: tipoEvento,
      formaPagamento: formaPagamentoEvento,
      nomeCliente: nomeClienteEvento,
      contatoCliente: contatoClienteEvento,
      entradaPago: entradaPagoEvento,
    );

    _eventos.add(evento);
    _eventos.refresh();
  }

  setEvento() {}

  cancelarCriacaoEvento() {
    limparDia();
    setValorEvento(0.0);
    setTipoEvento("");
    setDescricaoEvento("");
    setEntradaPagoEvento(false);
    setFormaPagamentoEvento("");
    setNomeClienteEvento("");
    setContatoClienteEvento("");
  }
}
