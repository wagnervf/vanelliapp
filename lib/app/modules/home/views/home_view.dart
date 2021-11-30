import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/components/get_list_eventos_firebase.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class HomeView extends StatelessWidget {
  //Chama o Evento controller para buscar os eventos e preencher o calendário antes de abrir a tela de eventos...
  //Isso ajuda ao abrir a tela e eventos todos os eventos já foram buscandos no banco.
  // ignore: unused_field
  final EventoController _controller = Get.put(EventoController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBarCustom(
        title: 'Vanelli Mananger',
        color: kPrimaryColor,
        voltar: false,
      ),
      body: SafeArea(
        child: buildBodyHome(size, context),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  Container buildHeaderHome(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      alignment: Alignment.topCenter,
    );
  }

  Container buildBodyHome(Size size, BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildBalanco(),
          const SizedBox(height: 20),
          buildHeaderInfo('Ações'),
          buttonsCards(size),
          const Divider(),
          buildHeaderInfo('Atividades Recente'),
          const GetListEventosFirabase(),
        ],
      ),
    );
  }

  Container buttonsCards(Size size) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Componentsutils.cardInformation(
            size: size,
            icon: Icons.date_range,
            title: 'Eventos',
            color: kColorEventos,
          ),
          Componentsutils.cardInformation(
            size: size,
            icon: Icons.trending_up,
            title: 'Receitas',
            color: kColorReceitas,
          ),
          Componentsutils.cardInformation(
            size: size,
            icon: Icons.trending_down,
            title: 'Despesas',
            color: kColorDespesas,
          ),
        ],
      ),
    );
  }

  Container buildHeaderInfo(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.topLeft,

      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: ksecondaryColor),
      ),
      //   Container(
      //     padding: EdgeInsets.zero,
      //     margin: EdgeInsets.zero,
      //     decoration: BoxDecoration(
      //       color: Colors.purple[50],
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //     child: TextButton(
      //       onPressed: () {},
      //       child: Text(
      //         'Ver tudo',
      //         style: TextStyle(color: Colors.purple[600]),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }

  Container buttonSelectPeriodo({required String title, required bool active}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: active ? Colors.amber[100] : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(color: active ? Colors.amber[800] : Colors.grey),
        ),
      ),
    );
  }

  Column buildBalanco() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list_alt),
          label: const Text('Abril'),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Balanço do Mês',
            style: TextStyle(color: ksecondaryColor),
          ),
        ),
        const Text(
          'R\$ 5569,39',
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
