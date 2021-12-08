import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/modules/perfil/views/perfil_view.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
import 'package:vanelliapp/app/theme.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final double height;
  final String title;
  final Color color;
  final bool voltar;
  final LoginController loginController = Get.find();
  AppBarCustom({
    Key? key,
    this.height = 40,
    required this.title,
    required this.color,
    required this.voltar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor, //or set color with: Color(0xFF0000FF)
    ));
    final UserController userController = Get.find();

    return AppBar(
      //brightness: Brightness.dark,
      //toolbarHeight: 380,
      primary: true,
      backgroundColor: color,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: false,

      leading: voltar
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kPrimaryLightColor,
              ),
              onPressed: () => Get.back(),
            )
          : IconButton(
              icon: const Icon(
                Icons.menu,
                color: kPrimaryLightColor,
              ),
              onPressed: () => Get.to(() => PerfilView()),
            ),

      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
              child: Obx(
            () => Text(
              '${userController.user.displayName}',
              style: const TextStyle(color: kPrimaryLightColor),
            ),
          )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
