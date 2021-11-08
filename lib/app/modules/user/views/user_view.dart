import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

// ignore: use_key_in_widget_constructors
class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
