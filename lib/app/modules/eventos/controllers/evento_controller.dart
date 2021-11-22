import 'dart:core';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_model.dart';

class EventoController extends GetxController {
  //late DateTime _diaSelecionado = DateTime.obs;
  final Rx<DateTime> _diaSelecionado = DateTime.now().obs;
  final Rx<double> _valorEvento = 0.0.obs;

  Rx<DateTime> get diaSelecionado => _diaSelecionado;
  get valorDoEvento => _valorEvento.value;

  selecionarDia(value) {
    _diaSelecionado.value = value;
    _diaSelecionado.refresh();
  }

  setValor(value) {
    _valorEvento.value = value;
    _valorEvento.refresh();
  }

  limparDia() {
    _diaSelecionado.value = DateTime.now();
    _diaSelecionado.refresh();
    print(_diaSelecionado.value);
  }
}
