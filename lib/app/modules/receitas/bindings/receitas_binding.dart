import 'package:get/get.dart';

import '../controllers/receitas_controller.dart';

class ReceitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceitasController>(
      () => ReceitasController(),
    );
  }
}
