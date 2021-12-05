import 'package:flutter/material.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/theme.dart';

import '../controllers/perfil_controller.dart';
import 'perfil_body_view.dart';

// ignore: use_key_in_widget_constructors
class PerfilView extends GetView<PerfilController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Mais',
        color: kPrimaryColor,
        voltar: false,
      ),
      body: PerfilBodyView(),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}
