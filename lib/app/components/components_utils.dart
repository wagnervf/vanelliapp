import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';

import '../theme.dart';

class Componentsutils {
  // static Container builLabelValor() {
  //   return Container(
  //     padding: const EdgeInsets.all(4.0),
  //     alignment: Alignment.topLeft,
  //     child: const Text(
  //       'Valor',
  //       textAlign: TextAlign.left,
  //     ),
  //   );
  // }

  static Container buildInputValor(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Valor",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextFormField(
            controller: controller,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: inputDecorationValor(),
          ),
        ],
      ),
    );
  }

  static InputDecoration inputValorNormal(String hintText) {
    return InputDecoration(
      prefixIconConstraints: const BoxConstraints(
        minHeight: 52,
        minWidth: 32,
      ),
      hintText: hintText,
      // contentPadding: const EdgeInsets.all(20),
      enabledBorder: InputBorder.none,
      //filled: true,
    );
  }

  static Container iconList(IconData icon, Color cor) {
    return Container(
      padding: const EdgeInsets.only(top: 18.0),
      child: Icon(
        icon,
        color: cor,
      ),
    );
  }

  static TextStyle textStyle() {
    return const TextStyle(
      color: kTextColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }

  static InputDecoration inputDecorationValor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.all(5),
    );
  }

  static InputDecoration buildInputDecoration(IconData icon, String hintText) {
    return InputDecoration(
      icon: Icon(icon),
      prefixIconConstraints: const BoxConstraints(
        minHeight: 52,
        minWidth: 32,
      ),
      hintText: hintText,
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: InputBorder.none,
      //filled: true,
    );
  }

  static TextStyle textValueList() {
    return const TextStyle(
      color: kTextLightColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle textLabelList() => const TextStyle(
        fontWeight: FontWeight.w300,
        color: kTextLightColor,
      );

  static Card cardInformation({
    required Size size,
    required IconData icon,
    required String title,
    // required String valor,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: size.width * .22,
        height: size.height * .15,
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42.0,
              height: 42.0,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 4.0, top: 4.0),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.0,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  static Card buildBodyListRecentes(EventoModel doc) {
    String data =
        DateFormat('dd/MM').format(DateTime.parse(doc.diaCompleto)).toString();
    var part = data.split('/');

    return Card(
      elevation: 2,
      shape: Border(
          left: BorderSide(
              color: doc.reservaPago
                  ? const Color(0xFF81c784)
                  : const Color(0xFFe57373),
              width: 5)),
      child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              '${part[0]}\n${part[1]}',
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
          ),
          title: Text(
            doc.nomeCliente,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(doc.tipo),
          trailing: const Icon(
            Icons.arrow_right,
            color: kTextLightColor,
          )),
    );
  }

  static void messageAlert(String title) {
    return Get.rawSnackbar(
        icon: const Icon(
          Icons.info_outline,
          color: Colors.deepOrange,
        ),
        messageText: Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(8.0),
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        isDismissible: true,
        snackPosition: SnackPosition.TOP);
  }
}
 // ElevatedButton buttonConfirmar() {
  //   return ElevatedButton.icon(
  //       label: Text(
  //         'Confirmar',
  //         style: TextStyle(
  //           fontSize: getHeight(context) * .03,
  //           color: Colors.white,
  //         ),
  //       ),
  //       style: styleButton(),
  //       onPressed: () => _acaoConfirmar(),
  //       icon: Visibility(
  //         visible: salvando,
  //         replacement: const Icon(Icons.check),
  //         child: const CircularProgressIndicator(
  //           color: Colors.white,
  //         ),
  //       ));
  // }


//   ButtonStyle styleButton() {
//     return ElevatedButton.styleFrom(
//       primary: kPrimaryColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
// }

// Widget previousButton() {
//   return Visibility(
//       visible: activeStep > 0,
//       child: SizedBox(
//           width: getWidth(context) * 0.3,
//           height: getHeight(context) * .05,
//           child: OutlinedButton(
//             onPressed: () {
//               if (activeStep > 0) {
//                 setState(() {
//                   activeStep--;
//                 });
//               }
//             },
//             child: Text(
//               'Voltar',
//               style: TextStyle(
//                 fontSize: getHeight(context) * .03,
//                 color: kPrimaryColor,
//               ),
//             ),
//             style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               side: const BorderSide(width: 1.0, color: kPrimaryColor),
//             ),
//           )));
// }
