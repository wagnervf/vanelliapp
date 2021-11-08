import 'package:flutter/material.dart';

import '../theme.dart';
import 'decorations.dart';

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

  static InputDecoration inputDecorationValor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.all(5),
    );
  }

  static InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.description_outlined),
      prefixIconConstraints: const BoxConstraints(
        minHeight: 52,
        minWidth: 32,
      ),
      hintText: hintText,
      contentPadding: const EdgeInsets.all(25),
      filled: true,
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
}
