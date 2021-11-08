import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKeyE = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

  final _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar senha'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyE,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Esqueci a senha',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Por favor, informe seu e-mail \npara a recuperação da senha.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getHeight(context) * 0.1),
                  buildTextFormFieldEmail(),
                  SizedBox(height: getHeight(context) * 0.1),
                  buttonEnviar(context),
                  SizedBox(height: getHeight(context) * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buttonEnviar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) * .07,
      child: Obx(() => ElevatedButton(
          onPressed: () => _submit(_formKeyE),
          child: loginController.loading
              ? showLoading()
              : Text(
                  'Enviar',
                  style: TextStyle(
                    fontSize: getHeight(context) * .03,
                    color: Colors.white,
                  ),
                ),
          style: styleElevatedButton())),
    );
  }

  _submit(_formKey) {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      loginController.resetPasswordFirebase(_email.text);
    }
  }

  Padding buildTextFormFieldEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "E-mail",
          hintText: "digite seu e-mail",
          suffixIcon: Icon(Icons.email_outlined),
        ),
        style: const TextStyle(
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        validator: Validatorless.multiple(
          [
            Validatorless.required('E-mail é obrigatório'),
            Validatorless.email('Email é inválido'),
          ],
        ),
      ),
    );
  }
}
