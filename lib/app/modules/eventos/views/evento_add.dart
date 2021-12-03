import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_cliente.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_revisao.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_evento.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoAdd extends StatefulWidget {
  const EventoAdd({Key? key}) : super(key: key);

  @override
  _EventoAddState createState() => _EventoAddState();
}

class _EventoAddState extends State<EventoAdd> {
  //final int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final EventoController _controller = Get.put(EventoController());

  late EventoModel? evento;
  late DateTime from;
  late DateTime to;
  late String dataSelecionada = _controller.diaSelecionado;
  // final TextEditingController _controlDescricao = TextEditingController();
  int activeStep = 0;
  int upperBound = 2;

  bool salvando = false;

  @override
  void initState() {
    setState(() {
      salvando = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //  color: Colors.purple,
            width: double.infinity,
            //  height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            child: Column(
              children: const [
                EventPassoEvento(),
                EventPassoCliente(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 3,
      automaticallyImplyLeading: false,
      // toolbarHeight: 40.0,
      title: const Text(
        'Informe os dados\ndo Evento',
        style: TextStyle(
          color: kTextLightColor,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        IconButton(
            icon: const Icon(
              Icons.check,
            ),
            tooltip: 'Salvar',
            onPressed: () => _acaoConfirmar()),
      ],
      centerTitle: true,
      leading: CloseButton(
        onPressed: () => _cancelarCriacaoEvento(),
        color: kTextLightColor,
      ),
    );
  }

  _acaoConfirmar() async {
    try {
      setState(() {
        salvando = true;
      });
      late bool dia = _controller.diaSelecionado.toString() == "";
      late bool valor = _controller.valorDoEvento == "";
      late bool tipo = _controller.tipoEvento == "";
      late bool forma = _controller.formaPagamentoEvento == "";
      late bool nome = _controller.nomeClienteEvento == "";
      late bool contato = _controller.contatoClienteEvento == "";

      if (dia || valor || tipo || forma || nome || contato) {
        Componentsutils.messageAlert('Verificar os campos não preenchidos!');
      }

      bool result = await _controller.saveEventoInCollectionFirebase();

      if (result) {
        Get.back();
        Componentsutils.messageAlert('Evento Salvo!');
      }

      setState(() {
        salvando = false;
      });

      return;
    } catch (e) {
      print(e);
      Componentsutils.messageAlert('Erro ao salvar Evento!');
      return;
    }
  }

  void _cancelarCriacaoEvento() {
    _controller.cancelarCriacaoEvento();
    Get.back();
  }
}
//https://www.youtube.com/watch?v=LoDtxRkGDTw

//https://www.youtube.com/watch?v=KvaKVud0Jx0
