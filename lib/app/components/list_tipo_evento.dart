import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/decorations.dart';

class ListTipoEvento extends StatelessWidget {
  final titles = ["Churras", "Casório", "Niver"];

  final subtitles = [
    "Churras no geral",
    "Noivado ou Casamento",
    "niver no geral"
  ];

  List<IconData> icons = [Icons.outdoor_grill, Icons.celebration, Icons.cake];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.turned_in_not_outlined),
      title: Text(
        'Tipo do Evento',
        style: TextStyle(color: Colors.grey[600]),
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
                onTap: () {
                  Get.back();
                },
                //  hoverColor: Colors.amber,
                //trailing: Icon(Icons.star),
              );
            }),
      ),
      isDismissible: true,
    );
  }
}
