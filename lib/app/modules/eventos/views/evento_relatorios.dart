import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/bar_chart_widget.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/components/select_date_mes.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoRelatorios extends StatefulWidget {
  const EventoRelatorios({Key? key}) : super(key: key);

  @override
  _EventoRelatoriosState createState() => _EventoRelatoriosState();
}

class _EventoRelatoriosState extends State<EventoRelatorios> {
  final EventoController _controller = Get.find<EventoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      body: SafeArea(
        child: buildBody(context),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  SizedBox buildBody(context) {
    String total = _controller.totalEventoMes.toString().replaceAll('.', ',');
    String qtdeEventos = _controller.qtdeEventoMes.toString();
    return SizedBox(
      height: getHeight(context),
      child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            _controller.selecionarMesFiltro(data: DateTime.now(), limit: false);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildHeaderInfo(context),
              itemList(Icons.paid_outlined, 'Total do Mês', "R\$ $total"),
              const Divider(),
              itemList(Icons.bar_chart, 'Total do Evento', qtdeEventos),
              buildTitleLinha('Tipos de evento'),
              Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.totalTipoEventoMes.first.length,
                    itemBuilder: (context, index) {
                      var item = _controller.totalTipoEventoMes.first;

                      return itemList(
                        Componentsutils.iconesStatics(
                            item.keys.elementAt(index)),
                        item.keys.elementAt(index),
                        item.values.elementAt(index).toString(),
                      );
                    },
                  )),
              buildTitleLinha('Formas de pagamento'),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      _controller.totalFormaPagamentoEventoMes.first.length,
                  itemBuilder: (context, index) {
                    var item = _controller.totalFormaPagamentoEventoMes.first;

                    return itemList(
                      Componentsutils.iconesStatics(item.keys.elementAt(index)),
                      item.keys.elementAt(index),
                      item.values.elementAt(index).toString(),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  children: [
                    itemList(
                      Icons.api,
                      'PIX',
                      "",
                    ),
                    itemList(
                      Icons.payment,
                      'Cartão',
                      "",
                    ),
                    itemList(
                      Icons.attach_money,
                      'Dinheiro',
                      "",
                    )
                  ],
                ),
              ),
              // const Divider(),
              //  const BarChartEidget(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTitleLinha(String title) {
    return Container(
      color: Colors.grey[50],
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Container buildHeaderInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      alignment: Alignment.topCenter,
      color: Colors.grey[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Relatórios do mês',
            style: styleFilter(),
          ),
          const SizedBox(height: 10),
          const SelectDateMes(),
        ],
      ),
    );
  }

  TextStyle styleFilter() {
    return const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: kTextColor);
  }

  ListTile itemList(IconData icon, String title, value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(color: kTextColor)),
      trailing: Text(
        value,
        style: styleItens(),
      ),
      dense: true,
    );
  }

  TextStyle styleItens() {
    return const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: kTextColor,
    );
  }
}
