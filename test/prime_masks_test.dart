import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

String _mask(TextInputFormatter f, String input) => f
    .formatEditUpdate(const TextEditingValue(), TextEditingValue(text: input))
    .text;

void main() {
  test('PrimeCpfMask', () {
    expect(_mask(PrimeCpfMask(), '12345678901'), '123.456.789-01');
    expect(_mask(PrimeCpfMask(), '123'), '123');
  });

  test('PrimeCnpjMask', () {
    expect(_mask(PrimeCnpjMask(), '12345678000190'), '12.345.678/0001-90');
  });

  test('PrimeTelefoneMask: 10 e 11 dígitos', () {
    expect(_mask(PrimeTelefoneMask(), '1133334444'), '(11) 3333-4444');
    expect(_mask(PrimeTelefoneMask(), '11987654321'), '(11) 98765-4321');
  });

  test('PrimeCepMask', () {
    expect(_mask(PrimeCepMask(), '12345678'), '12345-678');
  });

  test('PrimePlacaMask: antiga com hífen, Mercosul sem', () {
    expect(_mask(PrimePlacaMask(), 'abc1234'), 'ABC-1234');
    expect(_mask(PrimePlacaMask(), 'abc1d23'), 'ABC1D23');
  });

  test('PrimeRenavamMask: só dígitos, máx 11', () {
    expect(_mask(PrimeRenavamMask(), 'ab123c456'), '123456');
    expect(_mask(PrimeRenavamMask(), '123456789012345'), '12345678901');
  });
}
