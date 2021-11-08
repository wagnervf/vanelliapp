import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/modules/login/views/login_componentes.dart';
import 'package:vanelliapp/app/services/validators_custom.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

class FormCadastroView extends StatefulWidget {
  const FormCadastroView({Key? key}) : super(key: key);

  @override
  _FormCadastroViewState createState() => _FormCadastroViewState();
}

class _FormCadastroViewState extends State<FormCadastroView> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmaPassword = TextEditingController();

  bool _passwordVisible = true;
  bool _conformPasswordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    _conformPasswordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _password.dispose();
    _confirmaPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  SizedBox buildBody(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LoginComponentes.builBemVindo(
                  'Cadastrar uma conta',
                  'Por favor, informe seu dados \npara o cadastro da conta.',
                ),
                SizedBox(height: getHeight(context) * .05),
                buildTextFormFieldNome(),
                buildTextFormFieldEmail(),
                buildTextFormFieldSenha(),
                buildTextFormFieldConfirmaSenha(),
                SizedBox(height: getHeight(context) * .03),
                buttonCadastrar(context),
                SizedBox(height: getHeight(context) * .02),
                LoginComponentes.buidTermos(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buttonCadastrar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) * .07,
      child: Obx(() => ElevatedButton(
          onPressed: () => _submit(_formKey),
          child: loginController.loading
              ? showLoading()
              : Text(
                  'Cadastrar',
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
      Map<String, dynamic> userData = {
        "displayName": _nome.text,
        "email": _email.text,
      };

      loginController.createUserFirebase(
        userData: userData,
        password: _password.text,
      );
    }
  }

  Padding buildTextFormFieldNome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Nome",
          hintText: "Digite seu nome",
          suffixIcon: Icon(Icons.person_add_alt_outlined),
        ),
        style: const TextStyle(
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        keyboardType: TextInputType.text,
        controller: _nome,
        validator: Validatorless.multiple(
          [
            Validatorless.required('E-mail é obrigatório'),
          ],
        ),
      ),
    );
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

  Padding buildTextFormFieldSenha() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _password,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
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
        ),
        validator: Validatorless.multiple(
          [
            Validatorless.required('A Senha é obrigatória'),
            Validatorless.min(4, 'A Senha precida ter no mínimo 4 carateres'),
          ],
        ),
      ),
    );
  }

  Padding buildTextFormFieldConfirmaSenha() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _confirmaPassword,
        obscureText: !_conformPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Confirmar a senha',
          hintText: 'Digite novamente sua senha',
          suffixIcon: IconButton(
            icon: Icon(
              _conformPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _conformPasswordVisible = !_conformPasswordVisible;
              });
            },
          ),
        ),
        validator: Validatorless.multiple(
          [
            Validatorless.required('A confirmação da senha é obrigatória'),
            Validatorless.min(
                4, 'A confirmação da senha precida ter no mínimo 4 carateres'),
            ValidatorsCustom.compare(_password, 'As senhas não conferem')
          ],
        ),
      ),
    );
  }
}
