import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vanelliapp/app/modules/login/controllers/login_controller.dart';

class GoogleSignInProvider extends StatelessWidget {
  //final loginController = Get.put(LoginController());
  final LoginController loginController = Get.find();

  // GoogleSignIn? googleSignIn;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  // ignore: unused_field
  GoogleSignInAccount? currentUserGoogle;
  GoogleSignInProvider({
    Key? key,
    this.currentUserGoogle,
  }) : super(key: key);

  Future<void> _loginGoogle(BuildContext context) async {
    try {
      // googleSignIn!.signInSilently();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      currentUserGoogle = googleUser;

      final googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      loginController.setUserGoogleInFirebase(credential);

      // Get.to(() => UserView());
    } catch (error) {
      //print(error);
      showMessage(context, 'Não foi possível realizar o login');
    }
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Future<void> logoutGoogle() async {
  //   await googleSignIn.disconnect();
  //   FirebaseAuth.instance.signOut();
  //   loginController.setLogout();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          label: const Text('GOOGLE SIGN IN'),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: const Size(200, 50),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          onPressed: () => _loginGoogle(context),
        ),
      ],
    );
  }
}
