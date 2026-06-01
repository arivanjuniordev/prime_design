import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

String _format(TextInputFormatter f, String input) => f
    .formatEditUpdate(const TextEditingValue(), TextEditingValue(text: input))
    .text;

void main() {
  group('PrimeMoney', () {
    test(r'parse aceita "R$", milhar e decimal', () {
      expect(PrimeMoney.parse('1.234,56'), 123456);
      expect(PrimeMoney.parse(r'R$ 1.234,56'), 123456);
      expect(PrimeMoney.parse('0,99'), 99);
    });

    test('parse rejeita lixo e negativos', () {
      expect(PrimeMoney.parse('abc'), isNull);
      expect(PrimeMoney.parse('-5'), isNull);
    });

    test('format ↔ parse faz round-trip', () {
      expect(PrimeMoney.parse(PrimeMoney.format(123456)), 123456);
    });
  });

  group('PrimeLitros', () {
    test('format mostra litros em pt-BR', () {
      expect(PrimeLitros.format(40000), '40 L');
    });

    test('parse: último separador é o decimal', () {
      expect(PrimeLitros.parse('40,5'), 40500);
      expect(PrimeLitros.parse('40.5'), 40500); // evita virar 405 L
      expect(PrimeLitros.parse('1.234,5'), 1234500);
    });

    test('parse rejeita vazio/negativo', () {
      expect(PrimeLitros.parse(''), isNull);
      expect(PrimeLitros.parse('-1'), isNull);
    });
  });

  group('PrimeMoneyInputFormatter', () {
    test('formata centavos da direita pra esquerda', () {
      final out = _format(PrimeMoneyInputFormatter(), '12345');
      expect(out.contains('123,45'), isTrue);
    });

    test('texto vazio fica vazio', () {
      expect(_format(PrimeMoneyInputFormatter(), ''), '');
    });
  });
}
