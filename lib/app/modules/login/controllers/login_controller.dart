// ignore_for_file: void_checks

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:vanelliapp/app/modules/home/views/home_list.dart';
import 'package:vanelliapp/app/modules/home/views/home_view.dart';
import 'package:vanelliapp/app/modules/login/views/login_view.dart';
import 'package:vanelliapp/app/modules/user/controllers/user_controller.dart';
import 'package:vanelliapp/app/modules/user/model/user_model.dart';
import 'package:vanelliapp/app/services/handle_erros.dart';
import 'package:vanelliapp/app/services/messages_snackbar.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignInAccount? currentUserGoogle;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Map<String, dynamic> userData = {};
  //Rx<UserModel> _userLogadoModel = UserModel().obs;
  //UserModel get userLogadoModel => _userLogadoModel.value;

  final Rxn<User?> _firebaseUser = Rxn<User>();

  final _userFirebase = <User>[].obs;
  final _logged = false.obs;
  final _loading = false.obs;

  User get firebaseUser => _firebaseUser.value!;

  List<User> get userFirebase => _userFirebase;
  bool get userLogged => _logged.value;
  bool get loading => _loading.value;

  //@override
  // void onReady() {
//super.onReady();

  getUserLogged() {
    var firebaseUser = Rx<User?>(_auth.currentUser);
    var googleSignInAccount =
        Rx<GoogleSignInAccount?>(googleSignIn.currentUser);

    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSignIn.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? usuario) async {
    if (usuario == null) {
      Get.offAll(() => const LoginView());
    } else {
      Get.to(() => HomeList());

      Get.find<UserController>().user = await getUserCollection(usuario.uid);
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount == null) {
      Get.offAll(() => const LoginView());
    }
    Get.offAll(() => HomeList());
  }

  //Criar usuário no Firebase e salvar ele na colletions
  //
  Future createUserFirebase({
    required Map<String, dynamic> userData,
    required String password,
  }) async {
    try {
      setLoading(true);
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password,
      );

      UserModel _user = UserModel.fromDocumentCreate(
        doc: userCredential.user,
        name: userData["displayName"],
      );

      if (await _saveUserInCollectionFirebase(_user)) {
        Get.find<UserController>().user = _user;
        loginSucess();
      }
    } on FirebaseAuthException catch (e) {
      loginError();
      return HandleErros.getErroCreateUserFireabse(e);
    } catch (e) {
      loginError();
    }
  }

  //Login Firebase
  //
  Future loginInFirebase(
      {required String email, required String password}) async {
    try {
      setLoading(true);
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //buscado o usuário que foi salvo no BD
      Get.find<UserController>().user =
          await getUserCollection(result.user!.uid);
      loginSucess();

      //
    } on FirebaseAuthException catch (error) {
      loginError();
      return HandleErros.getErroLoginFireabse(error);
    } catch (e) {
      loginError();
    }
  }

  //Login Google
  Future loginGoogle() async {
    try {
      setLoading(true);
      final currentUserGoogle = await googleSignIn.signIn();
      if (currentUserGoogle == null) return;

      final googleAuth = await currentUserGoogle.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserModel _user = UserModel.fromDocumentSnapshotGoogle(currentUserGoogle);

      if (await _saveUserInCollectionFirebase(_user)) {
        Get.find<UserController>().user = _user;
        setUserGoogleInFirebase(credential);
        loginSucess();
      }
    } catch (error) {
      MessagesSnackbar.show('Não foi possível realizar o login');
    }
  }

  //Gravar o usuário do google nos usuários do Firebase
  void setUserGoogleInFirebase(AuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      loginSucess();
    } on FirebaseAuthException {
      MessagesSnackbar.show('Não foi possível salvar o usuário');
      loginError();
    }
  }

  // Salva usuário no banco do firebase
  Future<bool> _saveUserInCollectionFirebase(UserModel userData) async {
    try {
      await firestore.collection("users").doc(userData.uid).set({
        "displayName": userData.displayName,
        "email": userData.email,
        "emailVerified": userData.emailVerified,
        "isAnonymous": userData.isAnonymous,
        "photoURL": userData.photoURL,
        "providerId": userData.providerId,
      });
      return true;
    } catch (e) {
      MessagesSnackbar.show('Não foi possível salvar o usuário no firebase');
      return false;
    }
  }

  //buscar usuário banco do firebase
  Future<UserModel> getUserCollection(String uid) async {
    // ignore: prefer_typing_uninitialized_variables
    var user;
    try {
      await firestore.collection("users").doc(uid).get().then((value) {
        if (value.exists) {
          user = UserModel.fromDocumentSnapshot(value.data());
        }
      });

      return user;
    } catch (e) {
      MessagesSnackbar.show('Usuário não encontrado');
      rethrow;
    }
  }

  Future resetPasswordFirebase(String email) async {
    try {
      setLoading(true);
      final bool query = await checkIfEmailExist(email);
      if (query == false) {
        return MessagesSnackbar.show('E-mail não encontrado');
      }

      await _auth.sendPasswordResetEmail(email: email);
      MessagesSnackbar.show(
          'Um link para a troca da senha foi enviado ao seu e-mail');
      setLoading(false);
    } catch (e) {
      MessagesSnackbar.show('Usuário não encontrado');
      rethrow;
    }
  }

  checkIfEmailExist(String email) async {
    try {
      QuerySnapshot query = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (query.docs.isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      MessagesSnackbar.show('E-mail não encontrado');
      rethrow;
    }
  }

  void loginSucess() {
    setLogged(true);
    setLoading(false);
    Get.off(() => HomeView());
  }

  void loginError() {
    setLoading(false);
    setLogged(false);
    clearUser();
  }

  void setLoading(bool val) {
    _loading.value = val;
  }

  void setUserFirebase(user) {
    if (user != null) {
      _userFirebase.add(user);
      _userFirebase.refresh();
    }
  }

  void setLogged(bool value) {
    _logged.value = value;
    _logged.refresh();
  }

  void setLogoutAll() async {
    try {
      setLogged(true);
      var user = Get.find<UserController>().user.providerId;
      if (user == "password") await _auth.signOut();
      if (user == "google") await googleSignIn.disconnect();
      clearUser();
      loginError();
      Get.offAll(() => const LoginView());
    } catch (e) {
      MessagesSnackbar.show('Erro ao sair');
    }
  }

  void logoutGoogle() async {
    await googleSignIn.disconnect();
    setLogoutAll();
  }

  void clearUser() {
    Get.find<UserController>().clear();
    userData = {};
    _userFirebase.clear();
    _userFirebase.refresh();
  }
}
