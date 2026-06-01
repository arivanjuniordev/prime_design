import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prime_design/prime_design.dart';

void main() {
  const brand = Color(0xFF16A34A);

  group('PrimeTheme', () {
    test('injeta PrimeColors como ThemeExtension e propaga a marca', () {
      final theme = PrimeTheme.light(brand: brand);
      final colors = theme.extension<PrimeColors>();
      expect(colors, isNotNull);
      expect(colors!.accent, brand);
      expect(theme.colorScheme.primary, brand);
    });

    test('dark usa neutros escuros', () {
      final theme = PrimeTheme.dark(brand: brand);
      final colors = theme.extension<PrimeColors>()!;
      expect(colors.background, PrimePalette.backgroundDark);
      expect(colors.accent, brand);
    });

    test('usa a fonte Inter bundlada por padrão', () {
      final theme = PrimeTheme.light(brand: brand);
      expect(theme.textTheme.bodyMedium?.fontFamily,
          contains('Inter'));
    });
  });

  group('PrimeColors', () {
    test('deriva accentLight mais claro e accentDark mais escuro', () {
      final c = PrimeColors.light(brand);
      final l = HSLColor.fromColor(c.accentLight).lightness;
      final base = HSLColor.fromColor(c.accent).lightness;
      final d = HSLColor.fromColor(c.accentDark).lightness;
      expect(l, greaterThan(base));
      expect(d, lessThan(base));
    });

    test('respeita overrides explícitos de accentLight/Dark', () {
      const lightOverride = Color(0xFF00FF00);
      final c = PrimeColors.light(brand, accentLight: lightOverride);
      expect(c.accentLight, lightOverride);
    });

    test('copyWith troca só o campo informado', () {
      final c = PrimeColors.light(brand);
      final c2 = c.copyWith(accent: const Color(0xFF000000));
      expect(c2.accent, const Color(0xFF000000));
      expect(c2.background, c.background);
    });

    test('lerp(t:0) preserva o estado inicial', () {
      final a = PrimeColors.light(brand);
      final b = PrimeColors.light(const Color(0xFF2563EB));
      expect(a.lerp(b, 0).accent, a.accent);
    });

    test('border deriva de shadowDark com alpha baixo', () {
      final c = PrimeColors.light(brand);
      expect(c.border.a, lessThan(c.shadowDark.a));
    });
  });
}
