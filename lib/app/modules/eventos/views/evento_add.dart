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
import 'package:vanelliapp/app/modules/eventos/views/event_passo_cliente.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_revisao.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_passo_evento.dart';
import 'package:vanelliapp/app/shared/size_config.dart';
import 'package:vanelliapp/app/theme.dart';

class EventoAdd extends StatefulWidget {
  const EventoAdd({Key? key}) : super(key: key);

  @override
  _EventoAddState createState() => _EventoAddState();
}

class _EventoAddState extends State<EventoAdd> {
  final int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final EventoController _controller = Get.find();

  late EventoModel? evento;
  late DateTime from;
  late DateTime to;
  late String dataSelecionada = DateFormat("dd/MM/yyyy")
      .format(DateTime.parse(_controller.diaSelecionado.toString()));
  final TextEditingController _controlDescricao = TextEditingController();
  int activeStep = 0;
  int upperBound = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        title: const Text(
          'Novo Evento',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () => _cancelarCriacaoEvento(),
          color: Colors.redAccent,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                headerStepers(),
                steppersBody(),
                buttonProximo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container headerStepers() {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[50],
      height: size.height * .10,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(bottom: 12),
      child: IconStepper(
        icons: [
          Icon(
            Icons.paid_outlined,
            color: activeStep == 0 ? Colors.white : ksecondaryColor,
            size: 48,
          ),
          Icon(
            Icons.person,
            color: activeStep == 1 ? Colors.white : ksecondaryColor,
          ),
          Icon(
            Icons.check,
            color: activeStep == 2 ? Colors.white : ksecondaryColor,
          ),
        ],
        lineDotRadius: 2.0,
        stepRadius: 24,
        activeStepColor: kColorEventos,
        enableNextPreviousButtons: false,
        stepColor: Colors.white,
        activeStepBorderColor: Colors.transparent,
        activeStep: activeStep,
        stepReachedAnimationEffect: Curves.bounceOut,
        stepPadding: 4.0,
        onStepReached: (index) {
          setState(() {
            activeStep = index;
          });
        },
      ),
    );
  }

  steppersBody() {
    switch (activeStep) {
      case 0:
        return const EventPassoEvento();

      case 1:
        return const EventPassoCliente();

      case 2:
        return const EventPassoRevisao();

      default:
        return const EventPassoEvento();
    }
  }

  Widget buttonProximo() {
    return Container(
      width: getWidth(context) * .9,
      height: getHeight(context) * .07,
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        child: Text(
          'Próximo',
          style: TextStyle(
            fontSize: getHeight(context) * .03,
            color: Colors.white,
          ),
        ),
        style: styleButton(),
        onPressed: () => _acoeBotaoNext(),
      ),
    );
  }

  void _acoeBotaoNext() {
    if (activeStep < upperBound) {
      setState(() {
        activeStep++;
      });
    }
  }

  void _cancelarCriacaoEvento() {
    _controller.cancelarCriacaoEvento();
    Get.back();
  }

  ButtonStyle styleButton() {
    return ElevatedButton.styleFrom(
      primary: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

// Widget previousButton() {
//   return Visibility(
//       visible: activeStep > 0,
//       child: SizedBox(
//           width: getWidth(context) * 0.3,
//           height: getHeight(context) * .05,
//           child: OutlinedButton(
//             onPressed: () {
//               if (activeStep > 0) {
//                 setState(() {
//                   activeStep--;
//                 });
//               }
//             },
//             child: Text(
//               'Voltar',
//               style: TextStyle(
//                 fontSize: getHeight(context) * .03,
//                 color: kPrimaryColor,
//               ),
//             ),
//             style: OutlinedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               side: const BorderSide(width: 1.0, color: kPrimaryColor),
//             ),
//           )));
// }

//https://www.youtube.com/watch?v=LoDtxRkGDTw

//https://www.youtube.com/watch?v=KvaKVud0Jx0
