import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesSnackbar {
  static show(text) {
    Get.rawSnackbar(
      // title: 'Erro ${error.statusCode}',
      message: text,
      margin: const EdgeInsets.all(8.0),
      icon: const Icon(
        Icons.info_outline,
        color: Colors.blueAccent,
      ),
    );
  }
}
