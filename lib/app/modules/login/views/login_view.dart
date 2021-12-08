import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vanelliapp/app/components/header_widget.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/modules/login/views/login_componentes.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //final loginController = Get.put(LoginController());
  final LoginController loginController = Get.find();
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderWidget(
                getHeight(context),
                false,
                Icons.login_rounded,
              ), //let's create a common header widget

              Container(
                height: getHeight(context) - 120,
                width: double.infinity,
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/img/icon7.png",
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                        width: getWidth(context) * .6,
                        height: getHeight(context) * .1,
                      ),

                      SizedBox(height: getHeight(context) * 0.04),

                      const Text(
                        'Entre com seu usuário e senha',
                        style: subTitleLightStyle,
                        textAlign: TextAlign.center,
                      ),

                      buildTextFormFieldEmail(),
                      buildTextFormFieldSenha(),
                      SizedBox(height: getHeight(context) * 0.02),
                      buttonAcessar(context),
                      const Text('- ou -'),
                      LoginComponentes.buttonGoogle(),
                      LoginComponentes.esqueceuSenha(),
                      LoginComponentes.naoPossuiConta(),
                      //  LoginComponentes.buidTermos(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submit(_formKey) {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      loginController.loginInFirebase(
        email: _email.text,
        password: _password.text,
      );
    }
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
      decoration: inputDecorationTextForm(
        label: "E-mail",
        hint: "digite seu e-mail",
        icon: Icons.email_outlined,
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      validator: Validatorless.multiple(
        [
          Validatorless.required('E-mail é obrigatório'),
          Validatorless.email('Email é inválido'),
        ],
      ),
      style: const TextStyle(
        fontSize: 18,
        decoration: TextDecoration.none,
      ),
    );
  }

  InputDecoration inputDecorationTextForm(
      {required String label, required String hint, required IconData icon}) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      labelText: label,
      hintText: hint,
      fillColor: Colors.white,
      border: buildBorder12(),
    );
  }

  TextFormField buildTextFormFieldSenha() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _password,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        fillColor: Colors.white,
        border: buildBorder12(),
      ),
      validator: Validatorless.multiple(
        [
          Validatorless.required('A Senha é obrigatória'),
          Validatorless.min(4, 'A Senha precida ter no mínimo 4 carateres'),
        ],
      ),
    );
  }

  SizedBox buttonAcessar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) * .06,
      child: Obx(
        () => OutlinedButton(
          onPressed: () => _submit(_formKey),
          child: loginController.loading ? showLoading() : textEntrar(context),
          style: styleButtonEntrar(),
        ),
      ),
    );
  }

  ButtonStyle styleButtonEntrar() {
    return OutlinedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: const BorderSide(color: kPrimaryColor),
    );
  }

  Text textEntrar(BuildContext context) {
    return Text(
      'Entrar',
      style: TextStyle(
        fontSize: getHeight(context) * .03,
        color: Colors.white,
      ),
    );
  }

  OutlineInputBorder buildBorder12() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(),
    );
  }
}
