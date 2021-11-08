import 'package:flutter/material.dart';

import '../theme.dart';

class Decorations {
  static BoxDecoration decorationTextField() {
    return BoxDecoration(
      color: Colors.grey[100],
      // border: Border.all(
      //     color: Colors.grey, // set border color
      //     width: 1.0), // set border width
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ), // set rounded corner radius
    );
  }

  static InputDecoration inputDecorationDefault(String label) {
    return InputDecoration(
      //labelText: label,
      hintText: label,
      labelStyle: const TextStyle(
        color: Colors.grey,
      ),
      contentPadding: const EdgeInsets.all(20),
      disabledBorder: InputBorder.none,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          //borderSide: const BorderSide(color: Colors.grey),
          borderSide: BorderSide.none),
    );
  }

  static BoxDecoration boxDecorationCircular() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    );
  }

  static BoxDecoration boxDecorationCircularBottom(Color? color) {
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    );
  }
}
