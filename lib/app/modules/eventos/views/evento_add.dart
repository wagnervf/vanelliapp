import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/model/event_model.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_cliente.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_revisao.dart';
import 'package:vanelliapp/app/modules/eventos/views/event_passo_evento.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40.0,
        title: const Text(
          'Novo Evento',
          style: TextStyle(
            color: kTextLightColor,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () => _cancelarCriacaoEvento(),
          color: kTextLightColor,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                headerStepers(),
                steppersBody(),
                buttonSelected(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column headerStepers() {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: size.height * .10,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(bottom: 2),
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
        ),
        const Text(
          'Informe os dados\ndo Evento',
          style: TextStyle(
            color: kTextLightColor,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider()
      ],
    );
  }

  Widget buttonSelected() {
    return Container(
        width: getWidth(context),
        height: getHeight(context) * .07,
        margin: const EdgeInsets.all(10.0),
        child: Visibility(
          visible: activeStep < 2,
          child: buttonNext(),
          replacement: buttonConfirmar(),
        ));
  }

  ElevatedButton buttonConfirmar() {
    return ElevatedButton.icon(
        label: Text(
          'Confirmar',
          style: TextStyle(
            fontSize: getHeight(context) * .03,
            color: Colors.white,
          ),
        ),
        style: styleButton(),
        onPressed: () => _acaoConfirmar(),
        icon: const Icon(Icons.check));
  }

  void _acaoConfirmar() {
    _controller.setEventoModel();
    Get.back();
    messageAlert('Evento Salvo!');
  }

  ElevatedButton buttonNext() {
    return ElevatedButton(
      child: Text(
        'Próximo',
        style: TextStyle(
          fontSize: getHeight(context) * .03,
          color: Colors.white,
        ),
      ),
      style: styleButton(),
      onPressed: () => _acoeBotaoNext(),
    );
  }

  void _acoeBotaoNext() {
    late bool dia = _controller.diaSelecionado.toString() == "";
    late bool valor = _controller.valorDoEvento == "";
    late bool tipo = _controller.tipoEvento == "";
    late bool forma = _controller.formaPagamentoEvento == "";
    late bool nome = _controller.nomeClienteEvento == "";
    late bool contato = _controller.contatoClienteEvento == "";

    if (activeStep == 0) {
      if (dia || valor || tipo || forma) {
        messageAlert('Verificar os campos não preenchidos!');
      } else {
        _avancar();
      }
    } else if (activeStep == 1) {
      if (nome || contato) {
        messageAlert('Verificar os campos não preenchidos!');
      } else {
        _avancar();
      }
    }
  }

  void _avancar() {
    if (activeStep < upperBound) {
      setState(() {
        activeStep++;
      });
    }
  }

  steppersBody() {
    switch (activeStep) {
      case 0:
        return const EventPassoEvento();

      case 1:
        return const EventPassoCliente();

      case 2:
        return EventPassoRevisao();

      default:
        return const EventPassoEvento();
    }
  }

  void _cancelarCriacaoEvento() {
    _controller.cancelarCriacaoEvento();
    Get.back();
  }

  void messageAlert(String title) {
    return Get.rawSnackbar(
        icon: const Icon(
          Icons.info_outline,
          color: Colors.deepOrange,
        ),
        messageText: Text(
          title,
          style: TextStyle(color: Colors.white70),
        ),
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(8.0),
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        isDismissible: true,
        snackPosition: SnackPosition.TOP);
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
