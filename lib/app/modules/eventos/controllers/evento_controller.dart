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
  late DateTime _dia = DateTime.now();
  final _diaSelecionado = "".obs;
  final Rx<double> _valorEvento = 0.0.obs;
  final Rx<String> _tipoEvento = "".obs;
  final Rx<String> _descricaoEvento = "".obs;
  final Rx<bool> _entradaPago = true.obs;
  final Rx<String> _formaPagamentoEvento = "".obs;
  final Rx<String> _nomeClienteEvento = "".obs;
  final Rx<String> _contatoClienteEvento = "".obs;

  final RxBool buscando = false.obs;

  // final _eventos = <EventoModel>[].obs;

  get diaSelecionado => _diaSelecionado.value;
  get diaFomatado => _diaSelecionado.value;
  get tipoEvento => _tipoEvento.value;
  get valorDoEvento => _valorEvento.value;
  get descricaoDoEvento => _descricaoEvento.value;
  get entradaPagoEvento => _entradaPago.value;
  get formaPagamentoEvento => _formaPagamentoEvento.value;
  get nomeClienteEvento => _nomeClienteEvento.value;
  get contatoClienteEvento => _contatoClienteEvento.value;

  // List<EventoModel> get eventos => _eventos.toList();
  List<Appointment> _appointments = <Appointment>[].obs;
  //List<Appointment> get listaAppointments => _appointments.toList();
  EventDataSource get listaAppointments =>
      EventDataSource(_appointments.toList());

  @override
  void onInit() {
    print('***onInit***');
    getEventoCollection();
    super.onInit();
  }

  selecionarDiaEvento(value) {
    print('selecionarDiaEvento $value');
    //_dia = value;
    //print('_dia ${DateFormat('yyyy-MM-dd').format(value)}');
    _diaSelecionado.value = DateFormat('yyyy-MM-dd').format(value);
    //print(' _diaSelecionado.value ${_diaSelecionado.value} ');
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

  // setEventoModel() {
  //   final evento = EventoModel(
  //     dia: diaFomatado,
  //     valor: valorDoEvento,
  //     tipo: tipoEvento,
  //     formaPagamento: formaPagamentoEvento,
  //     nomeCliente: nomeClienteEvento,
  //     contatoCliente: contatoClienteEvento,
  //     entradaPago: entradaPagoEvento,
  //   );

  //   _eventos.add(evento);
  //   _eventos.refresh();
  // }

  // void setAppointment() {
  //   _appointments.add(
  //     Appointment(
  //       startTime: DateTime.parse(diaSelecionado),
  //       endTime: DateTime.parse(diaSelecionado),
  //       isAllDay: true,
  //       id: EventoModel(
  //         dia: diaSelecionado,
  //         valor: valorDoEvento,
  //         tipo: tipoEvento,
  //         formaPagamento: formaPagamentoEvento,
  //         nomeCliente: nomeClienteEvento,
  //         contatoCliente: contatoClienteEvento,
  //         entradaPago: entradaPagoEvento,
  //       ),
  //     ),
  //   );

  //   _saveEventoInCollectionFirebase();
  // }

  // Salva o Evento no banco do firebase
  Future<bool> saveEventoInCollectionFirebase() async {
    try {
      //salvando no banco
      await firestore.collection("eventos").doc(diaSelecionado).set({
        'startTime': diaSelecionado,
        'endTime': diaSelecionado,
        'isAllDay': true,
        'id': {
          'dia': diaSelecionado,
          'valor': valorDoEvento,
          'tipo': tipoEvento,
          'formaPagamento': formaPagamentoEvento,
          'nomeCliente': nomeClienteEvento,
          'contatoCliente': contatoClienteEvento,
          'entradaPago': entradaPagoEvento,
        }
      });

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
  void getEventoCollection() async {
    print('****getEventoCollection******');
    try {
      buscando.value = true;
      _appointments.clear();

      await firestore.collection("eventos").get().then((value) {
        var document = value.docs;
        if (document.isNotEmpty) {
          for (int i = 0; i < document.length; i++) {
            setAppointmentBD(document[i]);
          }
        }
      });

      buscando.value = false;
      buscando.refresh();
      update();

      // return evento;
    } catch (e) {
      MessagesSnackbar.show('Usuário não encontrado');
      rethrow;
    }
  }

  // Appointment mapedAppointment(doc) {
  //   return Appointment(
  //     startTime: DateTime.parse(doc["startTime"]),
  //     endTime: DateTime.parse(doc["endTime"]),
  //     isAllDay: doc["isAllDay"],
  //     id: EventoModel(
  //       dia: doc["id"]["dia"],
  //       valor: doc["id"]["valor"],
  //       tipo: doc["id"]["tipo"],
  //       formaPagamento: doc["id"]["formaPagamento"],
  //       nomeCliente: doc["id"]["nomeCliente"],
  //       contatoCliente: doc["id"]["contatoCliente"],
  //       entradaPago: doc["id"]["entradaPago"],
  //     ),
  //   );
  // }

  void setAppointmentBD(doc) {
    _appointments.add(
      Appointment(
        startTime: DateTime.parse(doc["startTime"]),
        endTime: DateTime.parse(doc["endTime"]),
        isAllDay: doc["isAllDay"],
        id: EventoModel(
          dia: doc["id"]["dia"],
          valor: doc["id"]["valor"],
          tipo: doc["id"]["tipo"],
          formaPagamento: doc["id"]["formaPagamento"],
          nomeCliente: doc["id"]["nomeCliente"],
          contatoCliente: doc["id"]["contatoCliente"],
          entradaPago: doc["id"]["entradaPago"],
        ),
      ),
    );
  }

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
