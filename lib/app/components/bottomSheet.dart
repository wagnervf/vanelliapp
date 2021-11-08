import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'decorations.dart';

class Bottomsheet extends StatelessWidget {
  final String label;
  final List<String> titles;
  final List<String> subtitles;
  final List<IconData> icons;
  final IconData iconList;

  Bottomsheet({
    required this.titles,
    required this.subtitles,
    required this.icons,
    required this.label,
    required this.iconList,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(iconList),
      title: Text(
        label,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: () => _openDialogBottom(size),
      selected: true,
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
