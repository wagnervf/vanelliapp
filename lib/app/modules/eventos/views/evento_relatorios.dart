import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/bar_chart_widget.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
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
    return SizedBox(
      height: getHeight(context),
      child: SingleChildScrollView(
        child: GetX<EventoController>(
          init: EventoController(),
          initState: (_) {},
          builder: (_) {
            String total = _.totalEventoMes.toString().replaceAll('.', ',');
            String qtdeEventos = _.qtdeEventoMes.toString();
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // buildHeaderInfo(context),
                // itemList(
                //   Icons.paid_outlined,
                //   'Total do Mês',
                //   "R\$ $total",
                // ),
                // const Divider(),
                // itemList(Icons.bar_chart, 'Total do Evento', qtdeEventos),
                // const Divider(),
                // itemList(
                //   Icons.event,
                //   'Tipos de evento',
                //   "",
                // ),
                Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _.totalTipoEventoMes.length,
                      itemBuilder: (context, index) {
                        return itemList(
                          Icons.outdoor_grill,
                          _.totalTipoEventoMes[index].toString(),
                          "",
                        );
                      },
                    )

                    // Column(
                    //   children: [
                    //     itemList(
                    //       Icons.outdoor_grill,
                    //       'Churras',
                    //       "",
                    //     ),
                    //     itemList(
                    //       Icons.celebration,
                    //       'Casamento',
                    //       "",
                    //     ),
                    //     itemList(
                    //       Icons.cake,
                    //       'Niver',
                    //       "",
                    //     )
                    //   ],
                    // ),

                    ),
                // const Divider(),
                // itemList(
                //   Icons.local_parking,
                //   'Formas de pagamento',
                //   "",
                // ),
                // Container(
                //   margin: const EdgeInsets.only(left: 12),
                //   child: Column(
                //     children: [
                //       itemList(
                //         Icons.api,
                //         'PIX',
                //         "",
                //       ),
                //       itemList(
                //         Icons.payment,
                //         'Cartão',
                //         "",
                //       ),
                //       itemList(
                //         Icons.attach_money,
                //         'Dinheiro',
                //         "",
                //       )
                //     ],
                //   ),
                // ),
                // const Divider(),
                // const BarChartEidget(),
              ],
            );
          },
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
      title: Text(title, style: TextStyle(color: kTextColor)),
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
