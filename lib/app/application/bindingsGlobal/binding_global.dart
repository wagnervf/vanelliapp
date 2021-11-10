import 'package:get/get.dart';
import 'package:vanelliapp/app/application/controllerGlobal/controller_global.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';

class BindingGlobal implements Bindings {
  @override
  void dependencies() {
    //dependências que serão globais no projeto
    //assim será gerenciando o dispose das denpendências

    // Get.lazyPut(() => CustomDio(), fenix: true);

    Get.lazyPut(() => ControllerGlobal(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
