import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/eventos/bindings/evento_binding.dart';
import 'package:vanelliapp/app/modules/eventos/views/evento_view.dart';
import 'package:vanelliapp/app/modules/home/bindings/home_binding.dart';
import 'package:vanelliapp/app/modules/home/views/home_view.dart';
import 'package:vanelliapp/app/modules/login/bindings/login_binding.dart';
import 'package:vanelliapp/app/modules/login/views/login_splash.dart';
import 'package:vanelliapp/app/modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN_SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SPLASH,
      page: () => const LoginSplash(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.EVENTO,
      page: () => const EventoView(),
      binding: EventoBinding(),
    ),
  ];
}
