import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/constants.dart';
import 'package:vanelliapp/app/theme.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final double height;
  final String title;
  final Color color;
  final bool voltar;

  AppBarCustom({
    Key? key,
    this.height = 35,
    required this.title,
    required this.color,
    required this.voltar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: kPrimaryColor,
      elevation: 0,
      // title: Text(
      //   title,
      //   style: TextStyle(color: color),
      // ),
      centerTitle: true,
      leading: Visibility(
        visible: voltar,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kColorDespesas,
          ),
          onPressed: () => Get.back(),
        ),
        replacement: IconButton(
          icon: const Icon(
            Icons.menu,
            color: kPrimaryLightColor,
          ),
          onPressed: () {},
        ),
      ),
      actions: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
              child: Text(
            'Alan',
            style: TextStyle(color: kPrimaryLightColor),
          )),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(this.height);
}
