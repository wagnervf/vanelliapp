import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/decorations.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class ListTipoEvento extends StatefulWidget {
  const ListTipoEvento({Key? key}) : super(key: key);

  @override
  State<ListTipoEvento> createState() => _ListTipoEventoState();
}

class _ListTipoEventoState extends State<ListTipoEvento> {
  final EventoController _controller = Get.find();

  final titles = ["CHURRAS", "CASAMENTO", "ANIVERSÁRIO"];
  final subtitles = [
    "Churras no geral",
    "Noivado ou Casamento",
    "niver no geral"
  ];

  List<IconData> icons = [Icons.outdoor_grill, Icons.celebration, Icons.cake];

  late IconData iconeSelecionado;

  @override
  void initState() {
    _setIcon(Icons.turned_in);
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
    bool tipoSelecionado = _controller.tipoEvento == "";
    return ListTile(
      contentPadding: const EdgeInsets.all(10.0),
      leading: Icon(
        iconeSelecionado,
        color: tipoSelecionado ? kTextLightColor : kPrimaryColor,
      ),
      title: Text(
        tipoSelecionado ? 'Tipo do Evento' : _controller.tipoEvento,
        style: TextStyle(
          color: kTextLightColor,
          fontWeight: tipoSelecionado ? FontWeight.normal : FontWeight.bold,
        ),
      ),
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
                onTap: () => _setTipoEventoList(titles[index], icons[index]),
              );
            }),
      ),
      isDismissible: true,
    );
  }

  void _setTipoEventoList(String tipo, IconData icon) {
    _controller.setTipoEvento(tipo);
    _setIcon(icon);
    Get.back();
  }
}
