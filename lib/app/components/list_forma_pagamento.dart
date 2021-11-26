import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/decorations.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class ListFormaPagamento extends StatefulWidget {
  const ListFormaPagamento({Key? key}) : super(key: key);

  @override
  State<ListFormaPagamento> createState() => _ListFormaPagamentoState();
}

class _ListFormaPagamentoState extends State<ListFormaPagamento> {
  final EventoController _controller = Get.find();

  final titles = ["PIX", "CARTÃO", "DINHEIRO"];
  final subtitles = ["Pix na conta", "Crédito dividido", "Pago pessoalmente"];

  List<IconData> icons = [Icons.api, Icons.payment, Icons.attach_money];

  late IconData iconeSelecionado;

  @override
  void initState() {
    _setIcon(Icons.request_quote);
    super.initState();
  }

  void _setIcon(IconData icon) {
    setState(() {
      iconeSelecionado = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool formaPagamentoSelecionado = _controller.formaPagamentoEvento == "";
    return ListTile(
      leading: Icon(
        iconeSelecionado,
        color: formaPagamentoSelecionado ? kTextLightColor : kPrimaryColor,
      ),
      title: Text(
        formaPagamentoSelecionado
            ? 'Forma de Pagamento'
            : _controller.formaPagamentoEvento,
        style: const TextStyle(
            color: kTextLightColor, fontWeight: FontWeight.bold),
      ),
      contentPadding: const EdgeInsets.all(10.0),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: () => _openDialogBottom(size),
    );
  }

  _openDialogBottom(Size size) {
    Get.bottomSheet(
      Container(
        height: size.height * 0.5,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: Decorations.boxDecorationCircular(),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: titles.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(titles[index]),
                subtitle: Text(subtitles[index]),
                leading: Icon(icons[index]),
                onTap: () =>
                    _setFormaPagamentoEventoList(titles[index], icons[index]),
                hoverColor: Colors.amber,
              );
            }),
      ),
      isDismissible: true,
    );
  }

  void _setFormaPagamentoEventoList(String tipo, IconData icon) {
    _controller.setFormaPagamentoEvento(tipo);
    _setIcon(icon);
    Get.back();
  }
}
