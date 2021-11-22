import 'package:flutter/material.dart';
import 'package:vanelliapp/app/components/app_bar.dart';
import 'package:vanelliapp/app/components/buttom_nav_bar.dart';
import 'package:vanelliapp/app/components/constants.dart';
import 'package:vanelliapp/app/components/customSwitch.dart';
import 'package:vanelliapp/app/components/decorations.dart';
import 'package:vanelliapp/app/components/list_contas.dart';
import 'package:vanelliapp/app/components/list_forma_pagamento.dart';
import 'package:vanelliapp/app/components/list_receitas.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../../theme.dart';
import '../controllers/receitas_controller.dart';

class ReceitasView extends StatefulWidget {
  @override
  State<ReceitasView> createState() => _ReceitasViewState();
}

class _ReceitasViewState extends State<ReceitasView> {
  final titles = ["List 1", "List 2", "List 3"];

  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];

  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

  final TextEditingController _controlDescricao = TextEditingController();

  final isSwitched = true;

  final isSwitchedC = false;

  final loginController = Get.put(LoginController());

  final _formKeyReceita = GlobalKey<FormState>();
  final TextEditingController _valor =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  //final _valor = TextEditingController();
  final _data = TextEditingController();
  final _categoria = TextEditingController();
  final _conta = TextEditingController();
  final _pago = TextEditingController();
  final _descricao = TextEditingController();

  @override
  void initState() {
    // _pago = false;
    _data.text = DateTime.now().toString();
    super.initState();
  }

  @override
  void dispose() {
    _valor.dispose();
    _data.dispose();
    _categoria.dispose();
    _conta.dispose();
    _pago.dispose();
    _descricao.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColorReceitas,
      appBar: AppBarCustom(
        title: 'Receitas',
        color: kColorReceitas,
        voltar: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderReceitas(size),
            buildBodyReceitas(size),
          ],
        ),
      )),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }

  Container buildHeaderReceitas(Size size) {
    return Container(
      color: kColorReceitas,
      height: size.height * .15,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: buildInputValor(),
    );
  }

  Form buildBodyReceitas(Size size) {
    return Form(
      key: _formKeyReceita,
      child: Container(
        decoration: Decorations.boxDecorationCircular(),
        height: size.height * .75,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            selectData(),
            const Divider(),
            ListReceitas(),
            const Divider(),
            ListContas(),
            const Divider(),
            CustomSwitch(
              icon: Icons.check_circle,
              label: 'Pago',
              isSwitched: isSwitched,
            ),
            const Divider(),
            textFormDescricao(),
            const Divider(),
            buttonCadastrar(context),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Container buildInputValor() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
            controller: _valor,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: inputDecorationValor(),
            validator: Validatorless.multiple(
              [
                Validatorless.required('O valor é obrigatório'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding textFormDescricao() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Descrição",
          // hintText: "Digite seu nome",
          prefixIcon: Icon(Icons.description),
          filled: true,
        ),
        style: const TextStyle(
          fontSize: 18,
          decoration: TextDecoration.none,
        ),
        keyboardType: TextInputType.text,
        controller: _descricao,
      ),
    );
  }

  ListTile selectData() {
    return ListTile(
      leading: const Icon(Icons.date_range),
      title: Text(
        dateFormat(selectedDate),
        style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 18.0),
      ),
      onTap: () => _selectDate(context),
    );
  }

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select booking date', // Can be used as title
      cancelText: 'Canlcelar',
      confirmText: 'Confirmar',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _data.text = picked.toString();
      });
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  String dateFormat(data) {
    return DateFormat("dd/MM/yyyy", 'pt_Br').format(data);
  }

  SizedBox buttonCadastrar(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: getHeight(context) * .07,
        child: Obx(() => ElevatedButton(
            onPressed: () => _submit(_formKeyReceita),
            child: loginController.loading
                ? showLoading()
                : Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: getHeight(context) * .03,
                      color: Colors.white,
                    ),
                  ),
            style: ElevatedButton.styleFrom(
                primary: kColorReceitas,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )))));
  }

  _submit(_formKey) {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      Map<String, dynamic> userData = {
        "pago": _pago.text,
        "valor": _valor.text,
        "data": _data.text,
        "categoria": _categoria.text,
        "conta": _conta.text,
        "descricao": _descricao.text,
      };

      print(userData);

      // loginController.createUserFirebase(
      //   userData: userData,
      //   password: _password.text,
      // );

    }
  }

  static inputDecorationValor() {}
}
