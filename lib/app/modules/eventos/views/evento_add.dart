import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_dados_cliente.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_dados_evento.dart';
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
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(6, 12, 6, 0),
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
        buttonSalvar(),
      ],
      centerTitle: true,
      leading: CloseButton(
        onPressed: () => _cancelarCriacaoEvento(),
        color: kTextLightColor,
      ),
    );
  }

  Container buttonSalvar() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: const Text('Salvar'),
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.all(2.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _acaoConfirmar(),
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
        Componentsutils.messageAlert(
            'Verifique os campos não preenchidos antes de Salvar!');
        return;
      }

      bool result = await _controller.saveEventoInCollectionFirebase();

      if (result) {
        Get.back();
        Componentsutils.messageAlert('Evento Salvo!');
        setState(() {
          salvando = false;
        });

        return;
      } else {
        Componentsutils.messageAlert('Erro ao salvar Evento!');
        return;
      }
    } catch (e) {
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
