import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    //  inputDecorationTheme: inputDecorationTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
        headline6: TextStyle(color: Color(0xff8b8b8b), fontSize: 16.0)),
  );
}

const kColorDespesas = Color(0xFFFD3C4A);
const kColorReceitas = Color(0xFF00c853);
const kColorEventos = Color(0xFF42a5f5);
const ksecondaryColor = Color(0xFFB5BFD0);
//const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

const kPrimaryColor = Color(0xFF049FFF);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF8d8d8d);
const kTextColor = Color(0xFF8d8d8d);

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

const defaultDuration = Duration(milliseconds: 250);

const headerStyle =
    TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);

InputDecorationTheme inputDecorationTheme() {
  return const InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 20.0,
    ),
    isDense: true,
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w200),
    // enabledBorder: buildOutlineInputBorder(),
    //focusedBorder: buildOutlineInputBorder(),
    // border: buildOutlineInputBorder(),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: const BorderSide(color: kTextColor),
  );
}

InputDecoration defaultInputDecoration(
    String label, String hint, IconData icon) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    // isDense: true,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      //height: 1.0,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
    suffixIcon: Icon(icon),
    hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w200),
  );
}

TextStyle stylelLink() {
  return const TextStyle(
    fontSize: 18.0,
    color: kPrimaryColor,
    fontWeight: FontWeight.bold,
  );
}

TextStyle stylelLink2() {
  return const TextStyle(
    fontSize: 14.0,
    color: kPrimaryColor,
    fontWeight: FontWeight.normal,
  );
}

const titleStyle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const subTitleLightStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  color: Colors.grey,
  height: 1.5,
);

ButtonStyle styleElevatedButton() {
  return ElevatedButton.styleFrom(
    primary: kPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

Center showLoading() {
  return Center(
      child: Container(
    //height: 80,
    margin: const EdgeInsets.all(8.0),
    child: const CircularProgressIndicator(
      color: Colors.white,
    ),
  ));
}
