// Dinheiro SEMPRE em centavos (int). Conversão pra "R$ X,YY" só na borda.
// Litros em mililitros (int): formatLitros divide por 1000.

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String formatMoney(int cents) {
  return NumberFormat.simpleCurrency(locale: 'pt_BR').format(cents / 100);
}

/// "123,45" / "R$ 123,45" → 12345 centavos. null se falhar.
int? parseMoney(String input) {
  final clean = input
      .replaceAll(RegExp(r'[Rr]\$\s*'), '')
      .replaceAll('.', '')
      .replaceAll(',', '.')
      .trim();
  final value = double.tryParse(clean);
  if (value == null || value < 0) return null;
  return (value * 100).round();
}

/// Litros em ml → "40,000 L".
String formatLitros(int ml) {
  return '${NumberFormat('#,##0.###', 'pt_BR').format(ml / 1000)} L';
}

/// "40" / "40,5" / "40.5" / "1.234,5" (litros) → ml. null se falhar.
/// O último separador (',' ou '.') é o decimal; o outro é milhar. Evita o bug
/// de "40.5" virar 405 L em teclados que usam ponto como separador decimal.
int? parseLitros(String input) {
  var s = input.trim();
  if (s.isEmpty) return null;
  final lastComma = s.lastIndexOf(',');
  final lastDot = s.lastIndexOf('.');
  if (lastComma >= 0 || lastDot >= 0) {
    final decSep = lastComma > lastDot ? ',' : '.';
    final thousandSep = decSep == ',' ? '.' : ',';
    s = s.replaceAll(thousandSep, '').replaceAll(decSep, '.');
  }
  final value = double.tryParse(s);
  if (value == null || value < 0) return null;
  return (value * 1000).round();
}

/// Formatter que digita centavos da direita pra esquerda ("R$ 12,34").
class MoneyTextInputFormatter extends TextInputFormatter {
  MoneyTextInputFormatter();

  static final _formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return const TextEditingValue(text: '');
    // Limita a 15 dígitos (~R$ 9 trilhões) — evita estouro de int em
    // int.parse ao colar valores absurdos. tryParse por segurança.
    if (digits.length > 15) digits = digits.substring(0, 15);
    final cents = int.tryParse(digits);
    if (cents == null) return oldValue;
    final formatted = _formatter.format(cents / 100);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
