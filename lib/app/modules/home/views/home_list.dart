import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/get_list_eventos_firebase.dart';
import 'package:vanelliapp/app/components/select_date_mes.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class HomeList extends StatelessWidget {
  //Chama o Evento controller para buscar os eventos e preencher o calendário antes de abrir a tela de eventos...
  //Isso ajuda ao abrir a tela e eventos todos os eventos já foram buscandos no banco.
  // ignore: unused_field
  final EventoController _controller = Get.put(EventoController());

  HomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCustom(
        title: '',
        color: kPrimaryColor,
        voltar: false,
      ),
      primary: true,
      body: SafeArea(
        child: buildBodyHome(size, context),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  buildBodyHome(Size size, BuildContext context) {
    return Column(
      children: [
        buildBalanco(context),
        buildHeaderInfo(context),
        buildListData(context),
      ],
    );
  }

  Container buildBalanco(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .2,
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: 4.0),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Text(
              'Balanço do Mês',
              style: TextStyle(color: kTextColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'R\$ 5569,39',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHeaderInfo(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .05,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      alignment: Alignment.topLeft,
      color: Colors.grey[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Atividades Recente',
            style: styleFilter(),
          ),
          const SelectDateMes(),
        ],
      ),
    );
  }

  buildListData(BuildContext context) {
    return Expanded(
      child: Container(
        //  height: MediaQuery.of(context).size.height * .5,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
        alignment: Alignment.topLeft,
        color: Colors.grey[50],
        child: const GetListEventosFirabase(),
      ),
    );
  }

  TextStyle styleFilter() {
    return const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: kTextColor);
  }
}
//   decoration: Componentsutils.borderCustom,
