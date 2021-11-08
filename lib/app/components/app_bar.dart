import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final double height;
  final String title;
  final Color color;
  final bool voltar;

  AppBarCustom({
    Key? key,
    this.height = 50,
    required this.title,
    required this.color,
    required this.voltar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: color,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: color != null ? Colors.white : color),
      ),
      centerTitle: true,
      leading: Visibility(
        visible: voltar,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: SvgPicture.asset("assets/icons/share.svg"),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: SvgPicture.asset("assets/icons/more.svg"),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(this.height);
}
