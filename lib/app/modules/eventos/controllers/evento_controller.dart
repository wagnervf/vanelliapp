import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_data_souce.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/services/messages_snackbar.dart';

class EventoController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //late DateTime _dia = DateTime.now();
  final _diaSelecionado = "".obs;
  final Rx<double> _valorEvento = 0.0.obs;
  final Rx<String> _tipoEvento = "".obs;
  final Rx<String> _descricaoEvento = "".obs;
  final Rx<bool> _totalEventoPago = false.obs;
  final Rx<bool> _reservaPago = false.obs;
  final Rx<String> _formaPagamentoEvento = "".obs;
  final Rx<String> _nomeClienteEvento = "".obs;
  final Rx<String> _contatoClienteEvento = "".obs;
  final Rx<int> _dia = 0.obs;
  final Rx<int> _mes = 0.obs;
  final Rx<int> _ano = 0.obs;
  final Rx<int> _idEvento = 0.obs;

  final RxBool buscando = false.obs;

  // final _eventos = <EventoModel>[].obs;

  get diaSelecionado => _diaSelecionado.value;
  get diaFomatado =>
      DateFormat('dd/MM/yyyy').format(DateTime.parse(_diaSelecionado.value));
  get tipoEvento => _tipoEvento.value;
  get valorDoEvento => _valorEvento.value;
  get descricaoDoEvento => _descricaoEvento.value;
  get reservaPagoEvento => _reservaPago.value;
  get totalPagoEvento => _totalEventoPago.value;
  get formaPagamentoEvento => _formaPagamentoEvento.value;
  get nomeClienteEvento => _nomeClienteEvento.value;
  get contatoClienteEvento => _contatoClienteEvento.value;

  // List<EventoModel> get eventos => _eventos.toList();
  List<Appointment> _appointments = <Appointment>[].obs;
  //List<Appointment> get listaAppointments => _appointments.toList();
  EventDataSource get listaAppointments =>
      EventDataSource(_appointments.toList());

  List eventosAll = [].obs;

  @override
  void onInit() {
    getEventoCollection();
    super.onInit();
  }

  selecionarDiaEvento(value) {
    _diaSelecionado.value = DateFormat('yyyy-MM-dd').format(value);
    _idEvento.value = Timestamp.fromDate(value).seconds;
    _dia.value = int.parse(DateFormat('dd').format(value));
    _mes.value = int.parse(DateFormat('MM').format(value));
    _ano.value = int.parse(DateFormat('yyyy').format(value));
    _diaSelecionado.refresh();
  }

  limparDia() {
    _diaSelecionado.value = "";
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

  setReservaPagoEvento(value) {
    _reservaPago.value = value;
    _reservaPago.refresh();
  }

  setTotalPagoEvento(value) {
    _totalEventoPago.value = value;
    _totalEventoPago.refresh();
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

  setDadosEvento() {
    final Map<String, dynamic> evento = {
      'id': _idEvento.value,
      'dia': _dia.value,
      'mes': _mes.value,
      'ano': _ano.value,
      'valor': valorDoEvento,
      'tipo': tipoEvento,
      'formaPagamento': formaPagamentoEvento,
      'nomeCliente': nomeClienteEvento,
      'contatoCliente': contatoClienteEvento,
      'reservaPago': reservaPagoEvento,
      'totalPago': totalPagoEvento,
      'idUsuario': 'Wagner',
      'dataCadastro': diaSelecionado,
      'diaCompleto': diaSelecionado,
      'isAllDay': true,
    };

    return (evento);
  }

  // Salva o Evento no banco do firebase

  Future<bool> saveEventoInCollectionFirebase() async {
    try {
      //salvando no banco
      String mesAno = '${_mes.value}-${_ano.value}';
      await firestore
          .collection("eventos")
          .doc(mesAno)
          .collection(mesAno)
          .doc(_idEvento.value.toString())
          .set(setDadosEvento());

      //Após salvar Busca no BR
      getEventoCollection();

      return true;
    } catch (e) {
      print(e);
      MessagesSnackbar.show('Não foi possível salvar o Evento!');
      return false;
    }
  }

  //buscar usuário banco do firebase
  Future getEventoCollection() async {
    print('****getEventoCollection******');
    try {
      int mes = int.parse(DateFormat('MM').format(DateTime.now()));
      int ano = int.parse(DateFormat('yyyy').format(DateTime.now()));
      String mesAno = '${mes}-${ano}';
      //_appointments.clear();

      await firestore
          .collection("eventos")
          .doc(mesAno)
          .collection(mesAno)
          .get()
          .then((querySnapshot) {
        var document = querySnapshot.docs;

        for (var element in document) {
          print(element.data());
          //  setAppointmentBD(element.data());
          _appointments.add(
            Appointment(
              startTime: DateTime.parse(element.data()["dataCadastro"]),
              endTime: DateTime.parse(element.data()["dataCadastro"]),
              isAllDay: element.data()["isAllDay"],
              id: EventoModel.fromMap(element.data()),
            ),
          );
        }
      });

      //eventosAll.addAll(lista);

      //setBuscando(false);

      return;
    } catch (e) {
      MessagesSnackbar.show('Usuário não encontrado');
      rethrow;
    }
  }

  void setAppointmentBD(map) {
    _appointments.add(
      Appointment(
        startTime: DateTime.parse(map["dataCadastro"]),
        endTime: DateTime.parse(map["dataCadastro"]),
        isAllDay: map["isAllDay"],
        id: EventoModel.fromMap(map),
      ),
    );
    update();
  }

  setBuscando(value) {
    buscando.value = value;
    buscando.refresh();
  }

  cancelarCriacaoEvento() {
    limparDia();
    setValorEvento(0.0);
    setTipoEvento("");
    setDescricaoEvento("");
    setReservaPagoEvento(false);
    setTotalPagoEvento(false);
    setFormaPagamentoEvento("");
    setNomeClienteEvento("");
    setContatoClienteEvento("");
  }
}
