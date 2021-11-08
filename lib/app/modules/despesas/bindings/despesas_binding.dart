import 'package:get/get.dart';

import '../controllers/despesas_controller.dart';

class DespesasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DespesasController>(
      () => DespesasController(),
    );
  }
}
