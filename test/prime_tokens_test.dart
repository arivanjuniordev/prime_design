import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

void main() {
  group('PrimeBreakpoint', () {
    test('fromWidth resolve cada faixa', () {
      expect(PrimeBreakpoint.fromWidth(500), PrimeBreakpoint.compact);
      expect(PrimeBreakpoint.fromWidth(700), PrimeBreakpoint.medium);
      expect(PrimeBreakpoint.fromWidth(1000), PrimeBreakpoint.expanded);
      expect(PrimeBreakpoint.fromWidth(1300), PrimeBreakpoint.large);
    });

    test('fromWidth nos limites exatos', () {
      expect(PrimeBreakpoint.fromWidth(599), PrimeBreakpoint.compact);
      expect(PrimeBreakpoint.fromWidth(600), PrimeBreakpoint.medium);
      expect(PrimeBreakpoint.fromWidth(839), PrimeBreakpoint.medium);
      expect(PrimeBreakpoint.fromWidth(840), PrimeBreakpoint.expanded);
      expect(PrimeBreakpoint.fromWidth(1199), PrimeBreakpoint.expanded);
      expect(PrimeBreakpoint.fromWidth(1200), PrimeBreakpoint.large);
    });

    test('getters de comparação', () {
      expect(PrimeBreakpoint.compact.isCompact, isTrue);
      expect(PrimeBreakpoint.compact.isAtLeastMedium, isFalse);
      expect(PrimeBreakpoint.medium.isAtLeastMedium, isTrue);
      expect(PrimeBreakpoint.expanded.isAtLeastExpanded, isTrue);
      expect(PrimeBreakpoint.medium.isAtLeastExpanded, isFalse);
    });
  });

  group('PrimeMotion', () {
    test('durações em ordem crescente', () {
      expect(PrimeMotion.fast < PrimeMotion.normal, isTrue);
      expect(PrimeMotion.normal < PrimeMotion.slow, isTrue);
    });

    testWidgets('*Of respeitam disableAnimations = true', (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(PrimeMotion.fastOf(ctx), Duration.zero);
      expect(PrimeMotion.normalOf(ctx), Duration.zero);
      expect(PrimeMotion.slowOf(ctx), Duration.zero);
      expect(PrimeMotion.curveOf(ctx), Curves.linear);
    });

    testWidgets('*Of retornam a duração normal com disableAnimations = false', (
      tester,
    ) async {
      late BuildContext ctx;
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: false),
          child: Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(PrimeMotion.fastOf(ctx), PrimeMotion.fast);
      expect(PrimeMotion.normalOf(ctx), PrimeMotion.normal);
      expect(PrimeMotion.slowOf(ctx), PrimeMotion.slow);
      expect(PrimeMotion.curveOf(ctx), PrimeMotion.curve);
    });
  });

  group('PrimeElevation', () {
    testWidgets('none e flat não têm sombra; high tem sombra', (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(PrimeElevation.none.shadows(ctx), isEmpty);
      expect(PrimeElevation.flat.shadows(ctx), isEmpty);
      expect(PrimeElevation.high.shadows(ctx), isNotEmpty);
    });
  });

  group('PrimeRadius', () {
    test('escala crescente', () {
      expect(PrimeRadius.xs < PrimeRadius.sm, isTrue);
      expect(PrimeRadius.sm < PrimeRadius.md, isTrue);
      expect(PrimeRadius.md < PrimeRadius.lg, isTrue);
      expect(PrimeRadius.lg < PrimeRadius.xl, isTrue);
      expect(PrimeRadius.xl < PrimeRadius.pill, isTrue);
    });
  });

  group('PrimeSpacing', () {
    test('escala crescente', () {
      expect(PrimeSpacing.xxs < PrimeSpacing.xs, isTrue);
      expect(PrimeSpacing.xs < PrimeSpacing.sm, isTrue);
      expect(PrimeSpacing.sm < PrimeSpacing.md, isTrue);
      expect(PrimeSpacing.md < PrimeSpacing.lg, isTrue);
      expect(PrimeSpacing.lg < PrimeSpacing.xl, isTrue);
      expect(PrimeSpacing.xl < PrimeSpacing.xxl, isTrue);
      expect(PrimeSpacing.xxl < PrimeSpacing.xxxl, isTrue);
      expect(PrimeSpacing.xxxl < PrimeSpacing.huge, isTrue);
    });
  });
}
