import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormValidate{

  static String? required(String? value, String? erro) {
    if(value == null || value.trim().isEmpty) return erro ?? 'Você precisa preencher esse campo';
    return null;
  }

  static String? requiredMax(String? value, int max, String? erro) {
    if(value == null || value.length > max) return erro ?? 'Máximo de $max caracteres';
    return null;
  }

  static String? requiredMin(String? value, int min, String? erro) {
    if(value == null || value.length < min) return erro ?? 'Mínimo de $min caracteres';
    return null;
  }

  static String? requiredLength(String? value, int length, String erro) {
    if(value == null || value.length != length) return erro;
    return null;
  }

  static String? rg(String? value) {
    if(value == null || value.length != 12) return 'RG inválido';
    return null;
  }

  static String? cpf(String? value) {
    if(value == null || value.length != 14) return 'CPF inválido';
    return null;
  }

  static String? cpfcnpj(String? value) {
    if(value == null || value.length != 18 && value.length != 14) return 'Documento inválido';
    return null;
  }

  static String? email(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if(value == null || !regex.hasMatch(value)) return 'Informe um e-mail válido';
    return null;
  }

  static String? placa(String? value) {
    String pattern = r'^([A-Z]{3}[0-9][0-9A-Z][0-9]{2})$';
    RegExp regex = RegExp(pattern);
    if(value == null || !regex.hasMatch(value.toUpperCase())) return 'Informe uma placa válida';
    return null;
  }

  static String? equals(String? value, String value2, String erro) {
    if(value != value2) return erro;
    return null;
  }

  static String? dataValidade(String? value, String erro) {
    if(value != null && value.isNotEmpty){
      String pattern = r'^(0[1-9]|1[0-2])\/?([0-9]{2})$';
      RegExp regex = RegExp(pattern);
      if(regex.hasMatch(value)){
        DateTime now = DateTime.now();
        int dano = int.parse(DateFormat('yy').format(now));
        int dmes = int.parse(DateFormat('MM').format(now));

        int vano = int.parse(value.substring(3, 5));
        int vmes = int.parse(value.substring(0, 2));

        if(vano > dano || (vano == dano && vmes >= dmes)) return null;
      }
    }
    return erro;
  }

  static String? data(String? value) {
    String pattern =
        r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$';
    RegExp regex = RegExp(pattern);
    if(value == null || !regex.hasMatch(value)) return 'Informe uma data válida';
    return null;
  }

}





class NumeroCartaoInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 13){
      newText =
      "${newText.substring(0, 4)} ${newText.substring(4, 8)} ${newText.substring(8, 12)} ${newText.substring(12, newText.length)}";

    }else if(newText.length >= 9) {
      newText =
      "${newText.substring(0, 4)} ${newText.substring(4, 8)} ${newText.substring(8, newText.length)}";

    }else if(newText.length >= 5) {
      newText =
      "${newText.substring(0, 4)} ${newText.substring(4, newText.length)}";
    }


    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}

class CPFInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 10){
      newText = "${newText.substring(0, 3)}.${newText.substring(3, 6)}.${newText.substring(6, 9)}-${newText.substring(9, newText.length)}";

    }else if(newText.length >= 7) {
      newText = "${newText.substring(0, 3)}.${newText.substring(3, 6)}.${newText.substring(6, newText.length)}";

    }else if(newText.length >= 4) {
      newText = "${newText.substring(0, 3)}.${newText.substring(3, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}

class CPFCNPJInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if (newText.length >= 14) {
      newText = "${newText.substring(0, 2)}.${newText.substring(2, 5)}.${newText.substring(5, 8)}/${newText.substring(8, 12)}-${newText.substring(12, newText.length)}";

    } else if(newText.length >= 12 && newText.length <= 13){
      newText = "${newText.substring(0, 2)}.${newText.substring(2, 5)}.${newText.substring(5, 8)}/${newText.substring(8, newText.length)}";

    } else if(newText.length >= 10){
      newText = "${newText.substring(0, 3)}.${newText.substring(3, 6)}.${newText.substring(6, 9)}-${newText.substring(9, newText.length)}";

    } else if(newText.length >= 7) {
      newText = "${newText.substring(0, 3)}.${newText.substring(3, 6)}.${newText.substring(6, newText.length)}";

    } else if(newText.length >= 4) {
      newText = "${newText.substring(0, 3)}.${newText.substring(3, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}

class CelularInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 3) {
      newText = "(${newText.substring(0, 2)}) ${newText.substring(2, newText.length)}";

    }else if(newText.isNotEmpty) {
      newText = "(${newText.substring(0, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}

class CEPInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 6) {
      newText = "${newText.substring(0, 5)}-${newText.substring(5, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}

class MesAnoInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 3) {
      newText = "${newText.substring(0, 2)}/${newText.substring(2, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection:  TextSelection.collapsed(offset: newText.length)
    );
  }
}

class DataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 5) {
      newText = "${newText.substring(0, 2)}/${newText.substring(2, 4)}/${newText.substring(4, newText.length)}";

    }else if(newText.length >= 3) {
      newText = "${newText.substring(0, 2)}/${newText.substring(2, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection:  TextSelection.collapsed(offset: newText.length)
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}


class RGInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0) return newValue;

    String newText = newValue.text;

    if(newText.length >= 9){
      newText = "${newText.substring(0, 2)}.${newText.substring(2, 5)}.${newText.substring(5, 8)}-${newText.substring(8, newText.length)}";

    }else if(newText.length >= 6) {
      newText = "${newText.substring(0, 2)}.${newText.substring(2, 5)}.${newText.substring(5, newText.length)}";

    }else if(newText.length >= 3) {
      newText = "${newText.substring(0, 2)}.${newText.substring(2, newText.length)}";
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length)
    );
  }
}