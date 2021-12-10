import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/modules/login/views/forgot_password_view.dart';
import 'package:vanelliapp/app/modules/login/views/form_cadastro_view.dart';
import 'package:vanelliapp/app/modules/login/views/login_view.dart';
import 'package:vanelliapp/app/theme.dart';

class LoginComponentes {
  LoginComponentes._();

  static Row esqueceuSenha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => Get.to(() => ForgotPasswordView()),
          child: Text(
            'Esqueceu a senha?',
            style: stylelLink2(),
          ),
        ),
      ],
    );
  }

  static Row naoPossuiConta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não possui conta?',
          style: TextStyle(fontSize: 16.0),
        ),
        TextButton(
          onPressed: () => Get.to(() => const FormCadastroView()),
          child: Text(
            'Criar Conta',
            style: stylelLink(),
          ),
        ),
      ],
    );
  }

  static Container buidTermos(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => {},
                child: const Text('Termo de Uso'),
              ),
              TextButton(
                onPressed: () => {},
                child: const Text('Termo de Privacidade'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Container buttonLogin() {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Acessar com o E-mail',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: kTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(200, 45),
            elevation: 2.0),
        icon: const FaIcon(
          FontAwesomeIcons.envelope,
          color: kTextColor,
        ),
        onPressed: () => {Get.to(() => const LoginView())},
      ),
    );
  }

  static Container buttonGoogle() {
    final LoginController loginController = Get.find();
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      child: Obx(
        () => ElevatedButton.icon(
          label: loginController.loading ? showLoading() : textGoogle(),
          style: stylebuttonGoogle(),
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.redAccent,
          ),
          onPressed: () => loginController.loginGoogle(),
        ),
      ),
    );
  }

  static ButtonStyle stylebuttonGoogle() {
    return ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: kSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      minimumSize: const Size(200, 45),
    );
  }

  static Row textGoogle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Acessar com o Google',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  static Column builBemVindo(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Text(
          subtitle,
          style: subTitleLightStyle,
        ),
      ],
    );
  }
}
