import 'package:flutter/material.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';

import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:get/get.dart';

import '../../../theme.dart';

// ignore: use_key_in_widget_constructors
class PerfilBodyView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          listDataUser(),
          SizedBox(height: getHeight(context) * .4),

          buttonSair()
          // ProfileMenuView(
          //   text: "Settings",
          //   //icon: Icon(Icons.settings),
          //   press: () {},
          // ),
          // ProfileMenuView(
          //   text: "Sair",
          //   //  icon: "assets/icons/Log out.svg",
          //   press: () => Get.to(() => LoginView()),
          // ),
        ],
      ),
    );
  }

  Padding buttonSair() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFF5F6F9),
        ),
        child: ListTile(
          leading: const Icon(Icons.logout, color: kTextLightColor),
          title: loginController.loading
              ? showLoading()
              : const Text(
                  'Sair',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
          onTap: () => loginController.setLogoutAll(),
        ),
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

  // SizedBox logoutFirebase(BuildContext context) {
  //   return SizedBox(
  //     width: getWidth(context) * .7,
  //     height: getHeight(context) * .07,
  //     child: Obx(
  //       () => ElevatedButton(
  //         onPressed: () => loginController.setLogoutAll(),
  //         child: loginController.loading
  //             ? showLoading()
  //             : Text(
  //                 'Logout Firebase',
  //                 style: TextStyle(
  //                   fontSize: getHeight(context) * .03,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //         style: styleElevatedButton(),
  //       ),
  //     ),
  //   );
  // }
}
