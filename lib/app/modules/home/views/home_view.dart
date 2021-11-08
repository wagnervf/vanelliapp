import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/components/constants.dart';
import 'package:vanelliapp/app/modules/despesas/views/despesas_view.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/modules/receitas/views/receitas_view.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

class HomeView extends StatelessWidget {
  final loginController = Get.put(LoginController());

  //get kColorReceitas => null;

  //get kColorDespesas => null;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBarCustom(
        title: 'Vanelli Mananger',
        color: kPrimaryColor,
        voltar: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderHome(context),
              buildBodyHome(size, context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  Container buildHeaderHome(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      alignment: Alignment.topCenter,
    );
  }

  Container buildBodyHome(Size size, BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildBalanco(),
          // const SizedBox(height: 12.0),
          textAcao(),
          rowCards(size),
          const Divider(),
          Column(
            children: [
              buildHeaderListRecentes(),
              buildBodyListRecentes(),
              buildBodyListRecentes(),
              buildBodyListRecentes(),
              buildBodyListRecentes(),
            ],
          ),
          logoutFirebase(context),
          testes()
        ],
      ),
    );
  }

  Row rowCards(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Componentsutils.cardInformation(
          size: size,
          icon: Icons.date_range,
          title: 'Eventos',
          color: kColorEventos,
        ),
        Componentsutils.cardInformation(
          size: size,
          icon: Icons.trending_up,
          title: 'Receitas',
          color: kColorReceitas,
        ),
        Componentsutils.cardInformation(
          size: size,
          icon: Icons.trending_down,
          title: 'Despesas',
          color: kColorDespesas,
        ),
      ],
    );
  }

  Container textAcao() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        'Ações',
        style: TextStyle(fontWeight: FontWeight.bold, color: ksecondaryColor),
      ),
    );
  }

  Container buildBodyListRecentes() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.shopping_basket,
            color: Colors.purple[600],
          ),
        ),
        title: const Text('Festa'),
        subtitle: const Text('Churras no gelera'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('R\$ 500,00'),
            Text('10:00 AM'),
          ],
        ),
      ),
    );
  }

  Row buildHeaderListRecentes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Atividades Recente',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: ksecondaryColor),
        ),
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Ver tudo',
              style: TextStyle(color: Colors.purple[600]),
            ),
          ),
        ),
      ],
    );
  }

  Container buttonSelectPeriodo({required String title, required bool active}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: active ? Colors.amber[100] : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(color: active ? Colors.amber[800] : Colors.grey),
        ),
      ),
    );
  }

  Column buildBalanco() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.arrow_drop_down),
          label: const Text('Abril'),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Balanço do Mês',
            style: TextStyle(color: ksecondaryColor),
          ),
        ),
        const Text(
          'R\$ 5569,39',
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
      ],
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
