import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:vanelliapp/app/application/bindingsGlobal/binding_global.dart';
import 'package:vanelliapp/app/modules/login/views/login_splash.dart';

import 'app/routes/app_pages.dart';

import 'app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: kPrimaryColor,
      // systemStatusBarContrastEnforced: false,
    ),
  );

  runApp(
    GetMaterialApp(
      title: "Vanelli Manager",
      theme: theme(),
      home: const LoginSplash(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingGlobal(),
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
    ),
  );
}
