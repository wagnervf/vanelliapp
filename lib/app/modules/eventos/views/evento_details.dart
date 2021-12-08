import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/components/app_bar.dart';

import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoDetails extends StatelessWidget {
  const EventoDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final EventoModel data = Get.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustom(
          title: 'Detalhes do Eventos',
          color: kPrimaryColor,
          voltar: true,
        ),
        backgroundColor: Colors.grey[50],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerActions(),
            listItens(data),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView listItens(EventoModel data) {
    return SingleChildScrollView(
      child: Container(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 8),
              dataEvento(data),
              const Divider(),
              itensEvento(Icons.person, 'Cliente', data.nomeCliente),
              itensEvento(Icons.phone, 'Contato', data.contatoCliente),
              itensEvento(Icons.monetization_on_sharp, 'Valor',
                  "R\$ ${data.valor.toString().replaceAll('.', ',')}0"),
              itensEvento(Icons.timeline, 'Tipo', data.tipo),
              itensEvento(Icons.api, 'Tipo', data.formaPagamento),
              const Divider(),
              itensEvento(Icons.person_outlined, 'Usuário', data.idUsuario),
              itensEvento(Icons.domain_verification_outlined,
                  'Data do Cadastro', data.dataCadastro),
            ],
          ),
        ),
      ),
    );
  }

  Container headerActions() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Evento do Dia',
              style: styleTitle(),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outlined,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  ListTile dataEvento(EventoModel data) {
    return ListTile(
        leading: const Icon(Icons.date_range),
        title: const Text(
          'Data',
          style: TextStyle(color: ksecondaryColor),
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy').format(DateTime.parse(data.diaCompleto)),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        dense: true);
  }

  TextStyle styleTitle() {
    return const TextStyle(
        color: kTextLightColor, fontSize: 20, fontWeight: FontWeight.bold);
  }

  Widget _subTitle(String title) {
    return Text(title, style: styleTitle());
  }

  Widget _title(String value) {
    return Text(value, style: const TextStyle(color: ksecondaryColor));
  }

  ListTile itensEvento(IconData icon, String title, String subtitle) {
    return ListTile(
        leading: Icon(icon),
        title: _title(title),
        subtitle: _subTitle(subtitle),
        dense: true);
  }
}
