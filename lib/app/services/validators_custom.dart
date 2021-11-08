import 'package:flutter/cupertino.dart';

class ValidatorsCustom {
  ValidatorsCustom._();

  //Recebe o valor do password valueControl?.text
  // Caso esteja tudo certo retorne nulo
  // Qualquer erro retorne uma mensagem

  static FormFieldValidator compare(
    TextEditingController? valueControl,
    String message,
  ) {
    return (value) {
      final valueCompare = valueControl?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
      return null;
    };
  }

// Recebo o valor que foi digitado do form da variavel value
// Comparo essa variável com qualquer coisa que qro nesse caso wagner e retorno a mensagem q digitar.

// Para usar comloco em um TextFormField
  //ValidatorsCustom.compare('O valor digitado deve ser wagner')

  static FormFieldValidator nomeEhIgual(String message) {
    return (value) {
      if (value != 'wagner') {
        return message;
      }
      return null;
    };
  }
}
