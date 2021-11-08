import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/home/views/home_view.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';

import 'login_view.dart';

class LoginSplash extends StatefulWidget {
  const LoginSplash({Key? key}) : super(key: key);

  @override
  _LoginSplashState createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash>
    with TickerProviderStateMixin {
  late AnimationController controller;
  final LoginController loginController = Get.find();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      return _getUser();
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _getUser() {
    setState(() {});
    //var user = FirebaseAuth.instance.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print(user);
      if (user != null) {
        Get.off(() => HomeView());
      } else {
        Get.off(() => const LoginView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            height: getHeight(context) * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: getHeight(context) * .2),
                SizedBox(
                  height: getHeight(context) * .1,
                  width: getHeight(context) * .1,
                  child: CircularProgressIndicator(
                    value: controller.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
