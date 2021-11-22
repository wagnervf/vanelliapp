import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/components/constants.dart';
import 'package:vanelliapp/app/components/list_forma_pagamento.dart';
import 'package:vanelliapp/app/components/list_tipo_evento.dart';
import 'package:vanelliapp/app/components/select_date_evento.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_model.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoAdd extends StatefulWidget {
  const EventoAdd({Key? key}) : super(key: key);

  @override
  _EventoAddState createState() => _EventoAddState();
}

class _EventoAddState extends State<EventoAdd> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final EventoController _controller = Get.find();

  late EventoModel? evento;
  late DateTime from;
  late DateTime to;
  late String dataSelecionada = DateFormat("dd/MM/yyyy")
      .format(DateTime.parse(_controller.diaSelecionado.toString()));
  final TextEditingController _controlDescricao = TextEditingController();
  late bool isSwitched = true;
  //late TextEditingController controlValor =
  //   MoneyMaskedTextController(leftSymbol: 'R\$ ');
  late TextEditingController controlValor = TextEditingController();
  //   MoneyMaskedTextController(leftSymbol: 'R\$ ');
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.

  int upperBound = 2; // upperBound MUST BE total number of icons minus 1.

  @override
  void initState() {
    int activeStep = 0;
    int upperBound = 2;
    controlValor.text = '600,00';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Novo Evento',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const CloseButton(),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.done),
            label: const Text('Salvar'),
          )
        ],
      ),
      body: buildBody(),
    );
  }

  SingleChildScrollView buildBody() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconStepper(
            icons: [
              Icon(
                Icons.paid,
                color: activeStep == 0 ? kPrimaryColor : ksecondaryColor,
              ),
              Icon(
                Icons.person,
                color: activeStep == 1 ? kPrimaryColor : ksecondaryColor,
              ),
              Icon(
                Icons.check,
                color: activeStep == 2 ? kPrimaryColor : ksecondaryColor,
              ),
            ],
            activeStepColor: Colors.white,
            stepColor: Colors.white,
            activeStepBorderColor: Colors.white,
            enableNextPreviousButtons: false,
            activeStep: activeStep,
            stepReachedAnimationEffect: Curves.bounceOut,
            stepPadding: 2.0,
            onStepReached: (index) {
              setState(() {
                activeStep = index;
              });
            },
          ),
          const Divider(),
          Container(
            height: size.height * .6,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: steppersBody(),
          ),
          Container(
            margin: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView passo_0() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SelectDateEvento(),
          const Divider(height: 2.0, thickness: 1.0),
          buildValor(),
          const Divider(height: 2.0, thickness: 1.0),
          ListTipoEvento(),
          const Divider(height: 2.0, thickness: 1.0),
          TextFormField(
            controller: _controlDescricao,
            decoration: Componentsutils.buildInputDecoration('Descrição'),
          ),
          const Divider(height: 2.0, thickness: 1.0),
          entraPago(),
          const Divider(height: 2.0, thickness: 1.0),
          ListFormaPagamento(),
        ],
      ),
    );
  }

  ListTile buildValor() {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.monetization_on_sharp),
        dense: true,
        visualDensity: VisualDensity.comfortable,
        title: TextFormField(
          controller: controlValor,
          style: textStyle(),
          decoration: Componentsutils.inputValorNormal('Valor'),
        ),
        trailing: CloseButton(
          onPressed: () => controlValor.text = '',
        ),
        onTap: () {});
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: kTextColor,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    );
  }

  ListTile entraPago() {
    return ListTile(
      leading: const Icon(Icons.check_circle),
      title: Text(
        'Entrada Pago',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      contentPadding: const EdgeInsets.all(2.0),
      trailing: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
        activeTrackColor: Colors.lightBlueAccent,
        activeColor: Colors.blueAccent,
      ),
    );
  }

  Column passo_01() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Home Address'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Postcode'),
        ),
      ],
    );
  }

  Column passo_02() {
    return Column(
      children: <Widget>[
        Text(_controller.diaSelecionado.toString()),
        Text(_controller.valorDoEvento.toString())
      ],
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
        print(double.parse(
            controlValor.text.replaceAll(',', '.').replaceAll('R\$ ', '')));
        _controller.setValor(double.parse(
            controlValor.text.replaceAll(',', '.').replaceAll('R\$ ', '')));
      },
      child: Text(
        "Próximo",
        style: textButton(),
      ),

      //icon: const Icon(Icons.arrow_right_alt),
    );
  }

  TextStyle textButton() {
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text(
        "Voltar",
        style: textButton(),
      ),
    );
  }

  Widget steppersBody() {
    switch (activeStep) {
      case 0:
        return passo_0();

      case 1:
        return passo_01();

      case 2:
        return passo_02();

      default:
        return passo_0();
    }
  }
}


//https://www.youtube.com/watch?v=LoDtxRkGDTw

//https://www.youtube.com/watch?v=KvaKVud0Jx0
