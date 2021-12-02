import 'package:flutter/material.dart';
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
  // static Container inputValorNormal(TextEditingController controller) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical: 10.0),
  //     child: TextFormField(
  //       controller: controller,
  //       keyboardType: TextInputType.number,
  //       textAlign: TextAlign.left,
  //       style: textStyle(),
  //       decoration: const InputDecoration(
  //         contentPadding: EdgeInsets.all(20),
  //         enabledBorder: InputBorder.none,
  //         icon: Icon(Icons.monetization_on),
  //         prefixIconConstraints: BoxConstraints(
  //           minHeight: 52,
  //           minWidth: 32,
  //         ),
  //         //filled: true
  //       ),
  //     ),
  //   );
  // }

  static TextStyle textStyle() {
    return const TextStyle(
      color: kTextColor,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    );
  }

  static InputDecoration inputDecorationValor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.all(5),
    );
  }

  static InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      icon: const Icon(Icons.subject),
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
              color: doc.entradaPago
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
}
