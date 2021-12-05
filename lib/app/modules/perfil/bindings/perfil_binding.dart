import 'package:get/get.dart';

import '../controllers/perfil_controller.dart';

class PerfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerfilController>(
      () => PerfilController(),
    );
  }
}
