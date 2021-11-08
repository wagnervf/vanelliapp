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
    required String valor,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: size.width * .43,
        height: size.height * .1,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  valor,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
