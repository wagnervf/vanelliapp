import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/components/list_forma_pagamento.dart';
import 'package:vanelliapp/app/components/list_tipo_evento.dart';
import 'package:vanelliapp/app/components/select_date_evento.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';

import '../../../theme.dart';

class EventPassoEvento extends StatefulWidget {
  const EventPassoEvento({Key? key}) : super(key: key);

  @override
  State<EventPassoEvento> createState() => _EventPassoEventoState();
}

class _EventPassoEventoState extends State<EventPassoEvento> {
  StepperType stepperType = StepperType.vertical;
  // final EventoController _controller = Get.find();
  final EventoController _controller = Get.put(EventoController());

  late String dataSelecionada = DateFormat("dd/MM/yyyy")
      .format(DateTime.parse(_controller.diaSelecionado.toString()));
  final TextEditingController _controlDescricao = TextEditingController();
  late TextEditingController controlValor = TextEditingController();
  late bool isSwitched = true;

  @override
  void initState() {
    controlValor.text = '600,00';
    _controller.setValorEvento(
      double.parse(
        controlValor.text.replaceAll(',', '.').replaceAll('R\$ ', ''),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: MediaQuery.of(context).size.height * .5,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SelectDateEvento(),
          const Divider(height: 2.0, thickness: 1.0),
          buildValor(),
          const Divider(height: 2.0, thickness: 1.0),
          const ListTipoEvento(),
          const Divider(height: 2.0, thickness: 1.0),
          entraPago(),
          const Divider(height: 2.0, thickness: 1.0),
          const ListFormaPagamento(),
          const Divider(height: 2.0, thickness: 1.0),
          // Container(
          //   padding: const EdgeInsets.all(10.0),
          //   margin: const EdgeInsets.all(6.0),
          //   child: TextFormField(
          //     controller: _controlDescricao,
          //     decoration:
          //         Componentsutils.buildInputDecoration('Adicionar Descrição'),
          //   ),
          // ),
        ],
      ),
    );
  }

  ListTile buildValor() {
    return ListTile(
        title: const Text('Valor'),
        leading: const Icon(
          Icons.monetization_on_sharp,
          color: kTextLightColor,
        ),
        dense: true,
        visualDensity: VisualDensity.comfortable,
        subtitle: TextFormField(
          controller: controlValor,
          onChanged: (value) => _saveValor(),
          style: textStyle(),
          decoration: Componentsutils.inputValorNormal('Valor'),
        ),
        trailing: CloseButton(onPressed: () {
          controlValor.text = '';
          _controller.setValorEvento("");
        }),
        onTap: () {});
  }

  void _saveValor() {
    _controller.setValorEvento(
      double.parse(
        controlValor.text.replaceAll(',', '.').replaceAll('R\$ ', ''),
      ),
    );
  }

  ListTile entraPago() {
    return ListTile(
      leading: Icon(
        Icons.price_check,
        color: isSwitched ? kPrimaryColor : kTextLightColor,
      ),
      title: const Text('Entrada Pago'),
      subtitle: Text(
        isSwitched ? 'SIM' : 'NÃO',
        style: const TextStyle(
            color: kTextLightColor, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      trailing: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
          _controller.setEntradaPagoEvento(value);
        },
        activeTrackColor: Colors.lightBlueAccent,
        activeColor: Colors.blueAccent,
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: kTextLightColor,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
  }
}
