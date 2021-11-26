import 'dart:core';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_model.dart';

class EventoController extends GetxController {
  //late DateTime _diaSelecionado = DateTime.obs;
  final Rx<DateTime> _diaSelecionado = DateTime.now().obs;
  final Rx<double> _valorEvento = 0.0.obs;
  final Rx<String> _tipoEvento = "".obs;
  final Rx<String> _descricaoEvento = "".obs;
  final Rx<bool> _entradaPago = true.obs;
  final Rx<String> _formaPagamentoEvento = "".obs;

  Rx<DateTime> get diaSelecionado => _diaSelecionado;
  get tipoEvento => _tipoEvento.value;
  get valorDoEvento => _valorEvento.value;
  get descricaoDoEvento => _descricaoEvento.value;
  get entradaPagoEvento => _entradaPago.value;
  get formaPagamentoEvento => _formaPagamentoEvento.value;

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

  cancelarCriacaoEvento() {
    limparDia();
    setValorEvento(0.0);
    setTipoEvento("");
    setDescricaoEvento("");
    setEntradaPagoEvento(false);
    setFormaPagamentoEvento("");
  }
}
