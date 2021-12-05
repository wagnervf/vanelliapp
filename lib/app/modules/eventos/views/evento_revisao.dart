import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class EventPassoRevisao extends StatelessWidget {
  EventPassoRevisao({Key? key}) : super(key: key);
  final EventoController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        height: size.height * .6,
        color: Colors.grey[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
                leading: Icon(Icons.date_range),
                title: const Text(
                  'Data',
                  style: TextStyle(color: ksecondaryColor),
                ),
                subtitle: Text(
                  _controller.diaFomatado,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                dense: true),
            const Divider(),
            buildLisiTitle(
                Icons.person, 'Cliente', _controller.nomeClienteEvento),
            buildLisiTitle(
                Icons.phone, 'Contato', _controller.contatoClienteEvento),
            buildLisiTitle(Icons.monetization_on_sharp, 'Valor',
                "R\$ ${_controller.valorDoEvento.toString().replaceAll('.', ',')}0"),
            buildLisiTitle(Icons.timeline, 'Tipo', _controller.tipoEvento),
            buildLisiTitle(Icons.api, 'Tipo', _controller.formaPagamentoEvento),
          ],
        ),
      ),
    );
  }

  Widget _subTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: kPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _title(String value) {
    return Text(value, style: const TextStyle(color: ksecondaryColor));
  }

  ListTile buildLisiTitle(IconData icon, String title, String subtitle) {
    return ListTile(
        leading: Icon(icon),
        title: _title(title),
        subtitle: _subTitle(subtitle),
        dense: true);
  }

  CircleAvatar buildFoto(Size size) {
    return CircleAvatar(
      radius: size.height * .080,
      backgroundColor: Color(0xFFDBE8FB),
      child: CircleAvatar(
        radius: size.height * .075,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
