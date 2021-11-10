import 'package:get/get.dart';

class ControllerGlobal extends GetxController {
  final tabIndex = 0.obs;

  int get index => tabIndex.value;

  @override
  void onInit() {
    changeTabIndex(0);
    super.onInit();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
