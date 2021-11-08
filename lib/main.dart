import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:vanelliapp/app/modules/login/views/login_splash.dart';

import 'app/modules/login/bindings/login_binding.dart';
import 'app/routes/app_pages.dart';

import 'app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: "Vabelliapp",
      theme: theme(),
      home: const LoginSplash(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: LoginBinding(),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    ),
  );
}
