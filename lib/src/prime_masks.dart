import 'package:flutter/services.dart';

/// Máscaras de input centralizadas (Brasil).
///
/// Cada formatter consome **apenas dígitos** (ou alfanuméricos, no caso de
/// placa) do texto digitado e reaplica a formatação na saída, mantendo o
/// cursor ao final do texto formatado. Nenhuma dependência de tema.

/// Aplica uma máscara posicional a partir de [digits], inserindo cada
/// caractere literal de [pattern] (qualquer char diferente de `0`).
///
/// Ex.: pattern `000.000.000-00` com `12345678901` → `123.456.789-01`.
String _applyPattern(String digits, String pattern) {
  final buffer = StringBuffer();
  var i = 0;
  for (final ch in pattern.split('')) {
    if (i >= digits.length) break;
    if (ch == '0') {
      buffer.write(digits[i]);
      i++;
    } else {
      buffer.write(ch);
    }
  }
  return buffer.toString();
}

/// Mantém apenas os dígitos (`0-9`) de [input].
String _digitsOnly(String input) => input.replaceAll(RegExp(r'[^0-9]'), '');

/// Posiciona o cursor no fim de [text].
TextEditingValue _atEnd(String text) => TextEditingValue(
  text: text,
  selection: TextSelection.collapsed(offset: text.length),
);

/// CPF: `000.000.000-00` (11 dígitos).
class PrimeCpfMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnly(newValue.text);
    final limited = digits.substring(0, digits.length.clamp(0, 11));
    return _atEnd(_applyPattern(limited, '000.000.000-00'));
  }
}

/// CNPJ: `00.000.000/0000-00` (14 dígitos).
class PrimeCnpjMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnly(newValue.text);
    final limited = digits.substring(0, digits.length.clamp(0, 14));
    return _atEnd(_applyPattern(limited, '00.000.000/0000-00'));
  }
}

/// Telefone: `(00) 00000-0000` (11 dígitos) ou `(00) 0000-0000` (10 dígitos).
class PrimeTelefoneMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnly(newValue.text);
    final limited = digits.substring(0, digits.length.clamp(0, 11));
    final pattern = limited.length > 10 ? '(00) 00000-0000' : '(00) 0000-0000';
    return _atEnd(_applyPattern(limited, pattern));
  }
}

/// CEP: `00000-000` (8 dígitos).
class PrimeCepMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnly(newValue.text);
    final limited = digits.substring(0, digits.length.clamp(0, 8));
    return _atEnd(_applyPattern(limited, '00000-000'));
  }
}

/// Placa BR em UPPERCASE: aceita Mercosul (`AAA0A00`) e antiga (`AAA-0000`).
///
/// Mantém até 7 caracteres alfanuméricos e força maiúsculo. Insere o hífen
/// após os 3 primeiros caracteres no formato antigo (4º char é dígito);
/// no Mercosul (4º char é dígito mas 5º é letra) não há hífen.
class PrimePlacaMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final raw = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9]'),
      '',
    );
    final limited = raw.substring(0, raw.length.clamp(0, 7));

    // Mercosul tem letra na 5ª posição (índice 4); placa antiga tem dígito.
    final isMercosul =
        limited.length >= 5 && RegExp(r'[A-Z]').hasMatch(limited[4]);

    if (!isMercosul && limited.length > 3) {
      final text = '${limited.substring(0, 3)}-${limited.substring(3)}';
      return _atEnd(text);
    }
    return _atEnd(limited);
  }
}

/// RENAVAM: apenas dígitos, máximo 11.
class PrimeRenavamMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = _digitsOnly(newValue.text);
    final limited = digits.substring(0, digits.length.clamp(0, 11));
    return _atEnd(limited);
  }
}
