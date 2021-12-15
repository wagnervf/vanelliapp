import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';

import '../theme.dart';

class Componentsutils {
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
          borderRadius: BorderRadius.circular(22),
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

  static BoxDecoration borderCustom = const BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40),
      topRight: Radius.circular(40),
    ),
    color: Colors.white,
  );

  static Card buildBodyListRecentes(EventoModel doc) {
    // String diaSemana = DateFormat.E('pt')
    //     .format(DateTime.parse(doc.diaCompleto))
    //     .toString()
    //     .toUpperCase();

    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(margin: EdgeInsets.zero, child: diaDaSemana(doc)),
        title: Text(
          doc.nomeCliente,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(doc.tipo),
        trailing: const Icon(
          Icons.arrow_right,
          color: kTextLightColor,
        ),
      ),
    );
  }

  static Container diaDaSemana(EventoModel doc) {
    String diaSemana = DateFormat.E('pt')
        .format(DateTime.parse(doc.diaCompleto))
        .toString()
        .toUpperCase();
    String mes = DateFormat.MMM('pt')
        .format(DateTime.parse(doc.diaCompleto))
        .toString()
        .toUpperCase();

    return Container(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            diaSemana,
            style: styleDiaSemana(),
            textAlign: TextAlign.center,
          ),
          Text(
            doc.dia.toString(),
            style: styleNumeroDia(doc),
            textAlign: TextAlign.center,
          ),
          Text(
            mes,
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }

  static TextStyle styleNumeroDia(EventoModel doc) {
    return TextStyle(
        color: doc.reservaPago ? Colors.teal : Colors.red,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);
  }

  static TextStyle styleDiaSemana() {
    return const TextStyle(
      color: kTextColor,
      fontSize: 14.0,
    );
  }

  static Card cardEventoAtual(EventoModel doc) {
    Color color =
        doc.reservaPago ? const Color(0xFF81c784) : const Color(0xFFe57373);

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Icon(
              Icons.person,
              color: color,
            ),
            title: Text(
              doc.nomeCliente,
              style: const TextStyle(fontSize: 18),
            ),
            tileColor: Colors.grey[100],
            trailing: IconButton(
              icon: const Icon(
                Icons.arrow_right,
                color: kPrimaryColor,
              ),
              onPressed: () {},
            ),
            subtitle: Text(
              doc.contatoCliente,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
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
