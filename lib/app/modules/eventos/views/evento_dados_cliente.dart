import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';

import '../../../theme.dart';

/// Entrypoint example for registering via Email/Password.
class EventPassoCliente extends StatefulWidget {
  /// The page title.
  final String title = 'Registration';

  const EventPassoCliente({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventPassoClienteState();
}

class _EventPassoClienteState extends State<EventPassoCliente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _contatoClienteController =
      TextEditingController();
  final EventoController _controller = Get.find();

  @override
  void initState() {
    if (_controller.nomeClienteEvento != "") {
      _nomeClienteController.text = _controller.nomeClienteEvento;
    }
    if (_controller.contatoClienteEvento != "") {
      _contatoClienteController.text = _controller.contatoClienteEvento;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Divider(height: 15.0, thickness: 1.0),
          const Text(
            'Cliente',
            textAlign: TextAlign.left,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            child: TextFormField(
              controller: _nomeClienteController,
              onChanged: (value) => save(),
              decoration: Componentsutils.buildInputDecoration(
                  Icons.person, 'Nome do Cliente'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            child: TextFormField(
              controller: _contatoClienteController,
              onChanged: (value) => save(),
              decoration: Componentsutils.buildInputDecoration(
                  Icons.phone, 'Contato do Cliente'),
            ),
          ),
        ],
      ),
    );
  }

  // ListTile inputNomeCliente() {
  //   return ListTile(
  //       contentPadding: const EdgeInsets.all(0),
  //       leading: const Icon(
  //         Icons.person,
  //         color: kPrimaryColor,
  //       ),
  //       dense: true,
  //       visualDensity: VisualDensity.comfortable,
  //       title: TextFormField(
  //         controller: _nomeClienteController,
  //         onChanged: (value) => save(),
  //         style: textStyle(_controller.nomeClienteEvento),
  //         decoration: Componentsutils.inputValorNormal('Cliente'),
  //       ),
  //       trailing: CloseButton(onPressed: () {
  //         _nomeClienteController.text = "";
  //         _controller.setNomeClienteEvento("");
  //       }),
  //       onTap: () {});
  // }

  // ListTile inputContatoCliente() {
  //   return ListTile(
  //       contentPadding: const EdgeInsets.all(10.0),
  //       leading: const Icon(
  //         Icons.phone,
  //         color: kPrimaryColor,
  //       ),
  //       dense: true,
  //       visualDensity: VisualDensity.comfortable,
  //       title: TextFormField(
  //         controller: _contatoClienteController,
  //         onChanged: (value) => save(),
  //         style: textStyle(_controller.contatoClienteEvento),
  //         decoration: Componentsutils.inputValorNormal('Contato'),
  //       ),
  //       trailing: CloseButton(onPressed: () {
  //         _contatoClienteController.text = "";
  //         _controller.setContatoClienteEvento("");
  //       }),
  //       onTap: () {});
  // }

  @override
  void dispose() {
    _nomeClienteController.dispose();
    _contatoClienteController.dispose();
    super.dispose();
  }

  save() {
    _controller.setNomeClienteEvento(
      _nomeClienteController.text,
    );

    _controller.setContatoClienteEvento(
      _contatoClienteController.text,
    );
  }

  TextStyle textStyle(String value) {
    return TextStyle(
      color: kTextLightColor,
      fontSize: 22.0,
      fontWeight: value == "" ? FontWeight.w300 : FontWeight.bold,
    );
  }
}
