// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/application/controllerGlobal/controller_global.dart';

import 'package:vanelliapp/app/modules/despesas/views/despesas_view.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_view.dart';
import 'package:vanelliapp/app/modules/home/views/home_view.dart';
import 'package:vanelliapp/app/modules/perfil/views/perfil_view.dart';
import 'package:vanelliapp/app/modules/receitas/views/receitas_view.dart';
import 'package:vanelliapp/app/theme.dart';

import 'constants.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  final ControllerGlobal dashController = Get.put(ControllerGlobal());

  int _selectedIndex = 0;
  BottomNavigationBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[50],
      unselectedItemColor: ksecondaryColor,
      selectedItemColor: kPrimaryColor,
      onTap: _changePage,
      currentIndex: dashController.index,
      iconSize: 24.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 5,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house_fill),
          label: 'Início',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.date_range),
          label: 'Eventos',
        ),
        // const BottomNavigationBarItem(
        //   icon: Icon(Icons.trending_down),
        //   label: 'Despesas',
        // ),
        // const BottomNavigationBarItem(
        //   icon: Icon(Icons.trending_up),
        //   label: 'Receitas',
        // ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_vert),
          label: 'Mais',
        ),
      ],
    );
  }

  void _changePage(int index) {
    dashController.changeTabIndex(index);
    print(index);

    switch (index) {
      case 0:
        // Get.until((route) => Get.currentRoute == '/home');
        Get.to(() => HomeView());
        break;
      case 1:
        // Get.until((route) => Get.currentRoute != '/evento');
        Get.to(() => const EventoView());
        break;
      case 2:
        Get.to(
          () => PerfilView(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
        break;
      case 3:
        Get.off(
          () => ReceitasView(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
        break;
      case 4:
        Get.to(
          () => PerfilView(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
        break;
    }
  }
}

// Container(
//   padding: const EdgeInsets.symmetric(vertical: 14),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     boxShadow: [
//       BoxShadow(
//         offset: const Offset(0, -15),
//         blurRadius: 20,
//         color: const Color(0xFFDADADA).withOpacity(0.15),
//       ),
//     ],
//   ),
//   child: SafeArea(
//     top: false,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         iconHome(inActiveIconColor),
//         iconEventos(inActiveIconColor),
//         iconDespesas(inActiveIconColor),
//         iconReceitas(inActiveIconColor),
//         iconMore(inActiveIconColor),
//       ],
//     ),
//   ),
// );

// ElevatedButton buttonsModal(
//     {required Color color,
//     required IconData icon,
//     required String text,
//     required String page}) {
//   return ElevatedButton(
//     onPressed: () => Get.toNamed(page),
//     child: Column(
//       children: [
//         Icon(
//           icon,
//           color: Colors.white,
//           size: 25.0,
//         ),
//         Text(
//           text,
//           textAlign: TextAlign.start,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 20.0,
//           ),
//         ),
//       ],
//     ),
//     style: ElevatedButton.styleFrom(
//       elevation: 4.0,
//       primary: color,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(18.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(80),
//       ),
//     ),
//   );
// }

//   iconHome(Color inActiveIconColor) {
//     return Container(
//       height: 40,
//       alignment: Alignment.topCenter,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: Icon(
//               CupertinoIcons.house_fill,
//               color: MenuState.home == widget.selectedMenu
//                   ? kPrimaryColor
//                   : inActiveIconColor,
//             ),
//             onPressed: () => Get.to(
//               () => HomeView(),
//             ),
//           ),
//           const Text('Início'),
//         ],
//       ),
//     );
//   }

//   IconButton iconEventos(Color inActiveIconColor) {
//     return IconButton(
//       icon: Icon(
//         Icons.date_range,
//         color:
//             MenuState.event == widget.selectedMenu ? kPrimaryColor : inActiveIconColor,
//       ),
//       onPressed: () => Get.to(
//         () => EventView(),
//       ),
//     );
//   }

//   IconButton iconDespesas(Color inActiveIconColor) {
//     return IconButton(
//       icon: Icon(
//         Icons.trending_down,
//         color:
//             MenuState.list == widget.selectedMenu ? kPrimaryColor : inActiveIconColor,
//       ),
//       onPressed: () => Get.to(
//         () => HomeView(),
//       ),
//     );
//   }

//   IconButton iconReceitas(Color inActiveIconColor) {
//     return IconButton(
//       icon: Icon(
//         Icons.trending_up,
//         color: MenuState.profile == widget.selectedMenu
//             ? kPrimaryColor
//             : inActiveIconColor,
//       ),
//       onPressed: () => Get.to(() => PerfilView()),
//     );
//   }

//   IconButton iconMore(Color inActiveIconColor) {
//     return IconButton(
//       icon: Icon(
//         Icons.more_vert,
//         color: MenuState.profile == widget.selectedMenu
//             ? kPrimaryColor
//             : inActiveIconColor,
//       ),
//       onPressed: () => Get.to(() => PerfilView()),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
