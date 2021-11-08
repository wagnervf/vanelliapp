import 'package:firebase_auth/firebase_auth.dart';

import 'messages_snackbar.dart';

class HandleErros {
  HandleErros._();

  static getErroCreateUserFireabse(FirebaseAuthException error) {
    if (error.code == 'weak-password') {
      MessagesSnackbar.show('A senha fornecida é muito fraca.');
    } else if (error.code == 'email-already-in-use') {
      MessagesSnackbar.show('Este email já está em uso em outra conta');
    }
  }

  static getErroLoginFireabse(FirebaseAuthException error) {
    switch (error.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        MessagesSnackbar.show("Este Email já está em uso por outra conta");
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        MessagesSnackbar.show("Email ou senha errada");
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        MessagesSnackbar.show("Nenhum usuário encontrado com este e-mail");
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        MessagesSnackbar.show("Usuário desabilitado");
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        MessagesSnackbar.show(
            "Excedido o limite de tentativas para esta conta, tente novamente mais tarde");
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        MessagesSnackbar.show("Erro do servidor, tente novamente mais tarde");
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        MessagesSnackbar.show("O endereço de e-mail é inválido");
        break;
      default:
        MessagesSnackbar.show("Falha no login. Tente novamente");
        break;
    }
  }
}
