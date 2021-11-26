import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';

class EventPassoRevisao extends StatefulWidget {
  const EventPassoRevisao({Key? key}) : super(key: key);

  @override
  _EventPassoRevisaoState createState() => _EventPassoRevisaoState();
}

class _EventPassoRevisaoState extends State<EventPassoRevisao> {
  final EventoController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_controller.diaSelecionado.toString()),
        Text(_controller.valorDoEvento.toString()),
        Text(_controller.tipoEvento.toString()),
        Text(_controller.descricaoDoEvento.toString()),
        Text('Entrada Pago: ${_controller.entradaPagoEvento ? 'SIM' : 'NÃO'}'),
        Text(_controller.nomeClienteEvento.toString()),
        Text(_controller.contatoClienteEvento.toString()),
      ],
    );
  }
}
