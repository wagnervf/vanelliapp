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
  final EventoController _controller = Get.find();
  late String dataSelecionada = DateFormat("dd/MM/yyyy")
      .format(DateTime.parse(_controller.diaSelecionado.toString()));
  final TextEditingController _controlDescricao = TextEditingController();
  late TextEditingController controlValor = TextEditingController();
  late bool isSwitched = true;

  @override
  void initState() {
    controlValor.text = '600,00';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SelectDateEvento(),
          buildValor(),
          const Divider(height: 2.0, thickness: 1.0),
          ListTipoEvento(),
          const Divider(height: 2.0, thickness: 1.0),
          entraPago(),
          const Divider(height: 2.0, thickness: 1.0),
          const ListFormaPagamento(),
          const Divider(height: 2.0, thickness: 1.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(6.0),
            child: TextFormField(
              controller: _controlDescricao,
              decoration:
                  Componentsutils.buildInputDecoration('Adicionar Descrição'),
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildValor() {
    return ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: const Icon(Icons.monetization_on_sharp),
        dense: true,
        visualDensity: VisualDensity.comfortable,
        title: TextFormField(
          controller: controlValor,
          onEditingComplete: () => _saveValor,
          style: textStyle(),
          decoration: Componentsutils.inputValorNormal('Valor'),
        ),
        trailing: CloseButton(
          onPressed: () => controlValor.text = '',
        ),
        onTap: () {});
  }

  void _saveValor() {
    print(controlValor.text.toString());

    _controller.setValorEvento(
      double.parse(
        controlValor.text.replaceAll(',', '.').replaceAll('R\$ ', ''),
      ),
    );

    //  _controller.setDescricaoEvento(_controlDescricao.text);

    //_controller.setTipoEvento(value)
  }

  ListTile entraPago() {
    return ListTile(
      leading: Icon(
        Icons.price_check,
        color: isSwitched ? kPrimaryColor : kTextLightColor,
      ),
      title: const Text(
        'Entrada Pago',
        style: TextStyle(
          color: kTextLightColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.all(10.0),
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
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    );
  }
}
