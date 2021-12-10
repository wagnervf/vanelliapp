import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/eventos/controllers/evento_controller.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';

class EventoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventoController>(
      () => EventoController(),
    );
    Get.lazyPut(() => EventoController());
    Get.lazyPut(() => UserController());
  }
}
