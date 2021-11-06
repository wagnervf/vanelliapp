import 'package:flutter/material.dart';
import 'package:vanelliapp/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFire Samples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: LoginScreen(),
    );
  }
}

//https://medium.com/flutter-community/flutter-crud-operations-using-firebase-cloud-firestore-a7ef38bbf027