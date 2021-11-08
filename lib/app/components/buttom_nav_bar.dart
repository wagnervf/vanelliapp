import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/event/views/event_view.dart';
import 'package:vanelliapp/app/modules/home/views/home_view.dart';
import 'package:vanelliapp/app/perfil/views/perfil_view.dart';
import 'package:vanelliapp/app/shared/enums.dart';
import 'package:vanelliapp/app/theme.dart';

import 'components_utils.dart';
import 'constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconHome(inActiveIconColor),
            iconCalendar(inActiveIconColor),
            floatButton(size, context),
            iconList(inActiveIconColor),
            iconProfile(inActiveIconColor),
          ],
        ),
      ),
    );
  }

  FloatingActionButton floatButton(Size size, BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _configurandoModalBottomSheet(size, context),
    );
  }

  void _configurandoModalBottomSheet(Size size, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(120),
            topRight: Radius.circular(120),
          ),
        ),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: size.height * .25,
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.0,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 24.0),
                    child: buttonsModal(
                      text: 'Evento',
                      color: kPrimaryColor,
                      icon: Icons.event,
                      page: '/event',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 44),
                    child: buttonsModal(
                      text: 'Receita',
                      color: kColorReceitas,
                      icon: Icons.trending_up,
                      page: '/receitas',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24.0),
                    child: buttonsModal(
                      text: 'Despesa',
                      color: kColorDespesas,
                      icon: Icons.trending_down,
                      page: '/despesas',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ElevatedButton buttonsModal(
      {required Color color,
      required IconData icon,
      required String text,
      required String page}) {
    return ElevatedButton(
      onPressed: () => Get.toNamed(page),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 25.0,
          ),
          Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        elevation: 4.0,
        primary: color,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }

  IconButton iconProfile(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.person_fill,
        color: MenuState.profile == selectedMenu
            ? kPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Get.to(() => PerfilView()),
    );
  }

  IconButton iconList(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.list_bullet,
        color:
            MenuState.list == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }

  IconButton iconCalendar(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.calendar,
        color:
            MenuState.event == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => EventView(),
      ),
    );
  }

  IconButton iconHome(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.house_fill,
        color:
            MenuState.home == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }
}
