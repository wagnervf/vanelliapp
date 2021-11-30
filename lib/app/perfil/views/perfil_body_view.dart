import 'package:flutter/material.dart';
import 'package:vanelliapp/app/modules/despesas/views/despesas_view.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/modules/login/views/login_view.dart';
import 'package:vanelliapp/app/modules/receitas/views/receitas_view.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
import 'package:vanelliapp/app/perfil/views/perfil_image_view.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:get/get.dart';

import '../../theme.dart';
import 'perfil_menu_view.dart';

// ignore: use_key_in_widget_constructors
class PerfilBodyView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PerfilImageView(),
          const SizedBox(height: 20),
          listDataUser(),
          SizedBox(height: getHeight(context) * .1),
          ProfileMenuView(
            text: "Settings",
            //icon: Icon(Icons.settings),
            press: () {},
          ),
          ProfileMenuView(
            text: "Sair",
            //  icon: "assets/icons/Log out.svg",
            press: () => Get.to(() => LoginView()),
          ),
          logoutFirebase(context),
          testes()
        ],
      ),
    );
  }

  Widget listDataUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFF5F6F9),
        ),
        child: GetX<UserController>(builder: (_) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(_.user.displayName.toString()),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: Text(_.user.email.toString()),
              ),
            ],
          );
        }),
      ),
    );
  }

  Column testes() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: GetX<UserController>(builder: (_) {
            return Column(
              children: [
                Text(_.user.displayName.toString()),
                Text(_.user.email.toString()),
              ],
            );
          }),
        ),
        TextButton(
          onPressed: () => loginController.logoutGoogle(),
          child: const Text('Google Logout'),
        ),
        TextButton(
          onPressed: () => Get.to(() => DespesasView()),
          child: const Text('Despesas'),
        ),
        TextButton(
          onPressed: () => Get.to(() => ReceitasView()),
          child: const Text('Receitas'),
        ),
      ],
    );
  }

  SizedBox logoutFirebase(BuildContext context) {
    return SizedBox(
      width: getWidth(context) * .7,
      height: getHeight(context) * .07,
      child: Obx(
        () => ElevatedButton(
          onPressed: () => loginController.setLogoutAll(),
          child: loginController.loading
              ? showLoading()
              : Text(
                  'Logout Firebase',
                  style: TextStyle(
                    fontSize: getHeight(context) * .03,
                    color: Colors.white,
                  ),
                ),
          style: styleElevatedButton(),
        ),
      ),
    );
  }
}
