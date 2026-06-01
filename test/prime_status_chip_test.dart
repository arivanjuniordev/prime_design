import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

void main() {
  group('PrimeStatusChip.colorFor', () {
    test('verde para status positivos', () {
      expect(PrimeStatusChip.colorFor('ativo'), PrimePalette.success);
      expect(PrimeStatusChip.colorFor('pago'), PrimePalette.success);
    });

    test('âmbar para status em progresso', () {
      expect(PrimeStatusChip.colorFor('pendente'), PrimePalette.warning);
      expect(PrimeStatusChip.colorFor('em_andamento'), PrimePalette.warning);
    });

    test('vermelho para status negativos', () {
      expect(PrimeStatusChip.colorFor('vencido'), PrimePalette.error);
      expect(PrimeStatusChip.colorFor('cancelado'), PrimePalette.error);
    });

    test('azul (info) como fallback', () {
      expect(PrimeStatusChip.colorFor('desconhecido'), PrimePalette.info);
    });
  });

  test('labelFor troca underscore por espaço', () {
    expect(PrimeStatusChip.labelFor('em_andamento'), 'em andamento');
  });
}
