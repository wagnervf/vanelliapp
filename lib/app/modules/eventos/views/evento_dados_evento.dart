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
  late bool reserva = false;
  late bool total = false;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        detailsDataValor(),
        // const Divider(height: 1.0, thickness: 1.0),
        detailsPagamento(),

        // const Divider(height: 2.0, thickness: 1.0),
      ],
    );
  }

  void _saveValor() {
    _controller.setValorEvento(
      double.parse(
        controlValor.text.replaceAll(',', '.').replaceAll('R\$ ', ''),
      ),
    );
  }

  Padding detailsDataValor() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const Divider(height: 15.0, thickness: 1.0),
          const Text(
            'Evento',
            textAlign: TextAlign.left,
          ),
          const SelectDateEvento(),
          buildValor(),
          const ListTipoEvento(),
        ],
      ),
    );
  }

  Padding detailsPagamento() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 15.0, thickness: 1.0),
          const Text(
            'Pagamento',
            textAlign: TextAlign.left,
          ),
          reservaPago(),
          eventoTotalPago(),
          const ListFormaPagamento(),
        ],
      ),
    );
  }

  ListTile buildValor() {
    return ListTile(
        title: Text('Valor', style: Componentsutils.textLabelList()),
        leading: Componentsutils.iconList(
            Icons.monetization_on_sharp, kTextLightColor),
        visualDensity: VisualDensity.comfortable,
        subtitle: TextFormField(
          controller: controlValor,
          onChanged: (value) => _saveValor(),
          style: Componentsutils.textValueList(),
          decoration: Componentsutils.inputValorNormal('Valor'),
        ),
        trailing: CloseButton(onPressed: () {
          controlValor.text = '';
          _controller.setValorEvento("");
        }),
        onTap: () {});
  }

  ListTile reservaPago() {
    return ListTile(
      leading: Componentsutils.iconList(
        Icons.price_check,
        reserva ? kPrimaryColor : kTextLightColor,
      ),
      title: Text(
        'Entrada Pago',
        style: Componentsutils.textLabelList(),
      ),
      subtitle: Text(
        reserva ? 'SIM' : '',
        style: Componentsutils.textValueList(),
      ),
      trailing: Switch(
        value: reserva,
        onChanged: (value) {
          setState(() {
            reserva = value;
          });
          _controller.setReservaPagoEvento(value);
        },
        activeTrackColor: Colors.lightBlueAccent,
        activeColor: Colors.blueAccent,
      ),
    );
  }

  ListTile eventoTotalPago() {
    return ListTile(
      leading: Componentsutils.iconList(
        Icons.price_check,
        total ? kPrimaryColor : kTextLightColor,
      ),
      title: Text(
        'Total do Evento Pago',
        style: Componentsutils.textLabelList(),
      ),
      subtitle: Text(
        total ? 'SIM' : '',
        style: Componentsutils.textValueList(),
      ),
      trailing: Switch(
        value: total,
        onChanged: (value) {
          setState(() {
            total = value;
          });
          _controller.setTotalPagoEvento(value);
        },
        activeTrackColor: Colors.lightBlueAccent,
        activeColor: Colors.blueAccent,
      ),
    );
  }
}
