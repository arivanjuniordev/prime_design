import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

/// Monta um host mínimo com um [MediaQuery] de [size] e captura o
/// [PrimeStyles] resolvido num context FILHO (via Builder), garantindo que
/// `MediaQuery.sizeOf` enxergue o tamanho injetado.
Future<PrimeStyles> _resolve(WidgetTester tester, Size size) async {
  late PrimeStyles captured;
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(size: size),
        child: Builder(
          builder: (context) {
            captured = context.styles;
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return captured;
}

void main() {
  group('PrimeStyles.scale (derivado do menor lado da tela)', () {
    testWidgets('shortestSide 400 (<=800) → scale 1.0', (tester) async {
      final styles = await _resolve(tester, const Size(400, 800));
      expect(styles.scale, 1.0);
    });

    testWidgets('shortestSide 900 (>800, <=1000) → scale 1.1', (tester) async {
      final styles = await _resolve(tester, const Size(900, 1200));
      expect(styles.scale, 1.1);
    });

    testWidgets('shortestSide 1100 (>1000) → scale 1.2', (tester) async {
      final styles = await _resolve(tester, const Size(1100, 1400));
      expect(styles.scale, 1.2);
    });

    testWidgets('usa o MENOR lado: paisagem larga mas baixa fica em 1.0', (
      tester,
    ) async {
      // Tela larga (1400) mas baixa (400): shortestSide = 400 → 1.0.
      final styles = await _resolve(tester, const Size(1400, 400));
      expect(styles.scale, 1.0);
    });

    testWidgets('limites exatos são exclusivos: 800 → 1.0 e 1000 → 1.1', (
      tester,
    ) async {
      // > 800 (não >=): exatamente 800 fica em 1.0.
      final at800 = await _resolve(tester, const Size(800, 1200));
      expect(at800.scale, 1.0);
      // > 1000 (não >=): exatamente 1000 fica em 1.1.
      final at1000 = await _resolve(tester, const Size(1000, 1400));
      expect(at1000.scale, 1.1);
    });
  });

  group('PrimeStyles derivados aplicam o scale', () {
    testWidgets('sized() e tokens de espaçamento no caso 1.2', (tester) async {
      final styles = await _resolve(tester, const Size(1100, 1400));
      expect(styles.scale, 1.2);

      // sized(v) == v * scale
      expect(styles.sized(10), 10 * 1.2);

      // tokens de espaçamento == PrimeSpacing.* * scale
      expect(styles.sm, PrimeSpacing.sm * 1.2);
      expect(styles.md, PrimeSpacing.md * 1.2);
      expect(styles.lg, PrimeSpacing.lg * 1.2);
      expect(styles.xl, PrimeSpacing.xl * 1.2);
    });

    testWidgets('no caso 1.0 os tokens são idênticos ao base', (tester) async {
      final styles = await _resolve(tester, const Size(400, 800));
      expect(styles.sized(10), 10);
      expect(styles.lg, PrimeSpacing.lg);
    });

    testWidgets('scaleText escala o fontSize; mantém quando null', (
      tester,
    ) async {
      final styles = await _resolve(tester, const Size(1100, 1400));
      const base = TextStyle(fontSize: 20);
      expect(styles.scaleText(base).fontSize, 20 * 1.2);

      // Sem fontSize não há o que escalar: devolve o mesmo style.
      const noSize = TextStyle();
      expect(styles.scaleText(noSize), same(noSize));
    });

    testWidgets('maxContentWidth é um cap fixo (não escala)', (tester) async {
      final small = await _resolve(tester, const Size(400, 800));
      final large = await _resolve(tester, const Size(1100, 1400));
      expect(small.maxContentWidth, 800);
      expect(large.maxContentWidth, 800);
    });
  });
}
