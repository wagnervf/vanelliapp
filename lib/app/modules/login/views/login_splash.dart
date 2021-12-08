import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/header_widget_splash.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';

class LoginSplash extends StatefulWidget {
  const LoginSplash({Key? key}) : super(key: key);

  @override
  _LoginSplashState createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash>
    with TickerProviderStateMixin {
  final LoginController loginController = Get.find();

  @override
  void initState() {
    super.initState();
    loginController.getUserLogged();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child:
            //  Image.asset("assets/img/icon4.png"),
            Column(
          children: [
            const HeaderWidgetSplash(),
            SizedBox(height: getHeight(context) * .2),
            const CupertinoActivityIndicator(),
          ],
        ), //
      ),
    );
  }
}
