import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_data_souce.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
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
  final List<Appointment> _appointments = <Appointment>[].obs;
  final Rxn<List<EventoModel>> _todosEventos = Rxn<List<EventoModel>>([]);
  List<EventoModel>? get todosEventos => _todosEventos.value;
  final Rx<double> _totalEventoMes = 0.0.obs;
  final Rx<int> _qtdeEventoMes = 0.obs;
  final RxList _totalTipoEventoMes = [].obs;
  final RxList _totalFormaPagamentoEventoMes = [].obs;

  final Rx<int> _mesFiltro =
      int.parse(DateFormat('MM').format(DateTime.now())).obs;
  int get mesSelecionado => _mesFiltro.value;

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
  get totalEventoMes => _totalEventoMes.value;
  get qtdeEventoMes => _qtdeEventoMes.value;
  get totalTipoEventoMes => _totalTipoEventoMes.toList();
  get totalFormaPagamentoEventoMes => _totalFormaPagamentoEventoMes.toList();

//https://www.youtube.com/watch?v=PQ_sxDjPUzU

  EventDataSource get listaAppointments =>
      EventDataSource(_appointments.toList());

  final List<Appointment> _appointmentsDoDia = <Appointment>[].obs;

  EventDataSource get listaAppointmentsDoDia =>
      EventDataSource(_appointmentsDoDia.toList());

  final UserController userController = Get.find();
  List eventosAll = [].obs;

  @override
  void onInit() {
    _todosEventos.bindStream(getEventosStream(
      mes: mesSelecionado,
      limit: true,
    ));

    getEventoCollection(mesV: DateTime.now(), anoV: DateTime.now());

    checkEventoDoDia();
    super.onInit();
  }

  void selecionarMesFiltro({required data, required bool limit}) {
    int mes = int.parse(DateFormat('MM').format(data));
    _mesFiltro.value = mes;
    _mesFiltro.refresh();
    _todosEventos.bindStream(getEventosStream(
      mes: mes,
      limit: limit,
    ));
  }

  Stream<List<EventoModel>> getEventosStream(
      {required int mes, required bool limit}) {
    int ano = int.parse(DateFormat('yyyy').format(DateTime.now()));
    String mesAno = '$mes-$ano';
    List<EventoModel> retVal = [];
    print('mesAno');
    print(mesAno);

    return firestore
        .collection("eventos")
        .doc(mesAno)
        .collection(mesAno)
        .limit(limit ? 5 : 40)
        .orderBy("id", descending: true)
        .snapshots()
        .map((query) {
      //

      if (query.docs.isNotEmpty) {
        somarTotalEventoMes(query.docs);
        setQtdeEventoMes(query.docs.length);
        somarTiposEventoMes(query.docs);
        somarFormaPagamentosEventoMes(query.docs);

        for (var element in query.docs) {
          retVal.add(EventoModel.fromMap(element.data()));
        }
        return retVal;
        //
      } else {
        setTotalEventoMes(0);
        setQtdeEventoMes(0);
        somarTiposEventoMes([]);
        somarFormaPagamentosEventoMes([]);
        return [];
      }
    });
  }

  void somarTiposEventoMes(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    final map = {};
    List elements = [];

    if (docs.isNotEmpty) {
      //Insere em uma lista os tipos de Eventos
      for (var element in docs) {
        elements.add(element['tipo']);
      }

      //realiza a contagem por tipos
      for (var element in elements) {
        if (!map.containsKey(element)) {
          map[element] = 1;
        } else {
          map[element] += 1;
        }
      }

      _totalTipoEventoMes.add(map);
    }
    _totalTipoEventoMes.add([]);
  }

  void somarFormaPagamentosEventoMes(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    final map = {};
    List elements = [];

    //Insere em uma lista os Forma de Pagamento
    for (var element in docs) {
      elements.add(element['formaPagamento']);
    }

    //realiza a contagem por tipos
    for (var element in elements) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    }
    _totalFormaPagamentoEventoMes.add(map);
  }

  void somarTotalEventoMes(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> map) {
    double valorTotal = 0;
    for (var element in map) {
      valorTotal += element['valor'];
    }
    if (valorTotal != 0) {
      setTotalEventoMes(valorTotal);
      return;
    } else {
      setTotalEventoMes(0);
    }
  }

  setQtdeEventoMes(int value) {
    _qtdeEventoMes.value = value;
    _qtdeEventoMes.refresh();
  }

  setTotalEventoMes(double value) {
    if (value > 0) {
      _totalEventoMes.value = value;
    }
    _totalEventoMes.value = 0.0;

    _totalEventoMes.refresh();
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
      'idUsuario': userController.user.displayName.toString(),
      'dataCadastro': diaSelecionado,
      'diaCompleto': diaSelecionado,
      'isAllDay': true,
    };

    return (evento);
  }

  List? checkEventoDoDia() {
    var hoje = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (var i = 0; i < _appointments.length; i++) {
      var start = DateFormat('yyyy-MM-dd').format(_appointments[i].startTime);
      if (start == hoje) {
        _appointmentsDoDia.add(_appointments[i]);
        return listaAppointmentsDoDia.appointments;
      }
    }
    return [];
    // print(_appointmentsDoDia);
  }

  // Salva o Evento no banco do firebase
  Future<bool> saveEventoInCollectionFirebase() async {
    try {
      String mesAno = '${_mes.value}-${_ano.value}';
      await firestore
          .collection("eventos")
          .doc(mesAno)
          .collection(mesAno)
          .doc(_idEvento.value.toString())
          .set(setDadosEvento());

      //Ap??s salvar Busca no BD
      getEventoCollection(mesV: DateTime.now(), anoV: DateTime.now());

      checkEventoDoDia();

      return true;
    } catch (e) {
      MessagesSnackbar.show('N??o foi poss??vel salvar o Evento!');
      return false;
    }
  }

  //buscar usu??rio banco do firebase
  Future getEventoCollection({required mesV, required anoV}) async {
    print('****getEventoCollection******');
    try {
      int mes = int.parse(DateFormat('MM').format(mesV));
      int ano = int.parse(DateFormat('yyyy').format(anoV));

      String mesAno = '$mes-$ano';
      await firestore
          .collection("eventos")
          .doc(mesAno)
          .collection(mesAno)
          .get()
          .then((querySnapshot) {
        var document = querySnapshot.docs;

        for (var element in document) {
          setAppointmentBD(element.data());
        }
      });

      return;
    } catch (e) {
      MessagesSnackbar.show('Usu??rio n??o encontrado');
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
