import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/decorations.dart';

class ListContas extends StatelessWidget {
  final titles = ["Empresa", "Alan / Thaís", "Wagner / Luana"];

  final subtitles = [
    "Conta da Empresa",
    "Conta Alan / Thaís",
    "Conta Wagner / Luana"
  ];

  List<IconData> icons = [Icons.business, Icons.flight, Icons.drive_eta];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      //contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.account_balance_wallet),
      title: Text(
        'Contas',
        style: TextStyle(color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () => _openDialogBottom(size),
      // selected: true,
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
                hoverColor: Colors.amber,
                //trailing: Icon(Icons.star),
              );
            }),
      ),
      isDismissible: true,
    );
  }
}
