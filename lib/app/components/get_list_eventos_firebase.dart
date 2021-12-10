import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_details.dart';

class GetListEventosFirabase extends StatefulWidget {
  const GetListEventosFirabase({Key? key}) : super(key: key);

  @override
  _GetListEventosFirabaseState createState() => _GetListEventosFirabaseState();
}

class _GetListEventosFirabaseState extends State<GetListEventosFirabase> {
  late List lists = [];

  @override
  Widget build(BuildContext context) {
    return GetX<EventoController>(
      init: Get.put<EventoController>(EventoController()),
      builder: (EventoController _controller) {
        if (_controller.todosEventos == null) {
          return const CircularProgressIndicator();
        } else if (_controller.todosEventos!.isEmpty) {
          return const Text('Nenhum Evento');
        } else {
          return ListView.builder(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            itemCount: _controller.todosEventos!.length,
            itemBuilder: (_, index) {
              return InkWell(
                child: Componentsutils.buildBodyListRecentes(
                  _controller.todosEventos![index],
                ),
                onTap: () => _goToEventoDetails(
                  _controller.todosEventos![index],
                ),
              );
            },
          );
        }
      },
    );
  }

  _goToEventoDetails(doc) {
    return Get.to(
      () => const EventoDetails(),
      arguments: doc,
    );
  }
}
