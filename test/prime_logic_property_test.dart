import 'package:flutter/services.dart';
import 'package:glados/glados.dart';
import 'package:prime_design/prime_design.dart';

// Property-based testing da camada de lógica pura: em vez de poucos exemplos,
// o glados gera centenas de entradas e tenta quebrar invariantes (com shrinking
// para o contraexemplo mínimo). Alto valor — pega edge cases que exemplos não veem.

String _applyMask(TextInputFormatter f, String text) => f
    .formatEditUpdate(const TextEditingValue(), TextEditingValue(text: text))
    .text;

void main() {
  // ---- PrimeMoney: round-trip format → parse (∀ centavos) ----------------
  Glados(any.intInRange(0, 1000000000)).test(
    'PrimeMoney: parse(format(cents)) == cents',
    (cents) {
      expect(PrimeMoney.parse(PrimeMoney.format(cents)), cents);
    },
  );

  // ---- PrimeLitros: round-trip da parte numérica (∀ ml) ------------------
  Glados(any.intInRange(0, 1000000000)).test(
    'PrimeLitros: parse(format(ml) sem unidade) == ml',
    (ml) {
      final numeric = PrimeLitros.format(ml).replaceAll(' L', '');
      expect(PrimeLitros.parse(numeric), ml);
    },
  );

  // ---- PrimeMoney.parse nunca lança e respeita não-negatividade ----------
  Glados(any.intInRange(-1000000, 1000000)).test(
    'PrimeMoney: format de não-negativos sempre re-parseia para o mesmo',
    (cents) {
      if (cents < 0) return; // format pressupõe centavos >= 0
      expect(PrimeMoney.parse(PrimeMoney.format(cents)), cents);
    },
  );

  // ---- Máscaras: idempotência + charset + limite de dígitos --------------
  final digits = any.intInRange(0, 999999999999999).map((n) => n.toString());

  Glados(digits).test('PrimeCpfMask: idempotente e só dígitos/separadores', (
    s,
  ) {
    final masked = _applyMask(PrimeCpfMask(), s);
    // Idempotência: aplicar de novo no resultado não muda nada.
    expect(_applyMask(PrimeCpfMask(), masked), masked);
    // Charset: apenas dígitos, ponto e hífen.
    expect(RegExp(r'^[0-9.\-]*$').hasMatch(masked), isTrue);
    // No máximo 11 dígitos (CPF).
    expect(
      masked.replaceAll(RegExp(r'[^0-9]'), '').length,
      lessThanOrEqualTo(11),
    );
  });

  Glados(digits).test('PrimeCnpjMask: idempotente e máx 14 dígitos', (s) {
    final masked = _applyMask(PrimeCnpjMask(), s);
    expect(_applyMask(PrimeCnpjMask(), masked), masked);
    expect(
      masked.replaceAll(RegExp(r'[^0-9]'), '').length,
      lessThanOrEqualTo(14),
    );
  });
}
