import 'package:flutter/material.dart';

/// Constantes neutras e semânticas do design system (flat, estilo guitarra_pro_z).
///
/// **Neutros e semânticos são fixos** — não variam por marca. A cor de marca
/// (accent) é parametrizável e vive em [PrimeColors] (um [ThemeExtension]),
/// acessada via `context.cs.accent`.
class PrimePalette {
  PrimePalette._();

  // ===== Neutros — Light =====
  static const Color background = Color(0xFFF5F6F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF0F2F5);
  static const Color shadowDark = Color(0xFF1F2330);
  static const Color textPrimary = Color(0xFF101218);
  static const Color textSecondary = Color(0xFF4B5163);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE5E7EB);

  // ===== Neutros — Dark =====
  static const Color backgroundDark = Color(0xFF0E1014);
  static const Color surfaceDark = Color(0xFF181B22);
  static const Color surfaceAltDark = Color(0xFF1F232C);
  static const Color shadowDarkDark = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFEDEFF5);
  static const Color textSecondaryDark = Color(0xFFB2B8C5);
  static const Color textMutedDark = Color(0xFF7B8294);
  static const Color dividerDark = Color(0xFF2D3142);

  // ===== Semânticos (fixos) =====
  static const Color error = Color(0xFFD92D20);
  static const Color warning = Color(0xFFF59E0B);
  static const Color success = Color(0xFF06A77D);
  static const Color info = Color(0xFF3B82F6);

  static const Color onAccent = Colors.white;
  static const Color scrim = Color(0xFF000000);

  /// Marca padrão do package (esmeralda Ecosafety). Apps passam a sua via
  /// `PrimeTheme.light(brand: ...)`.
  static const Color defaultBrand = Color(0xFF0E7C5A);
}

/// Clareia uma cor ajustando a luminância no espaço HSL.
Color _lighten(Color c, [double amount = 0.12]) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
}

/// Escurece uma cor ajustando a luminância no espaço HSL.
Color _darken(Color c, [double amount = 0.10]) {
  final hsl = HSLColor.fromColor(c);
  return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
}

/// Paleta resolvida do tema atual (brilho + marca), exposta como
/// [ThemeExtension]. Carrega a **cor de marca** (parametrizável) + os neutros
/// do brilho corrente. Acesse via `context.cs` — ex.: `context.cs.accent`.
@immutable
class PrimeColors extends ThemeExtension<PrimeColors> {
  const PrimeColors({
    required this.accent,
    required this.accentLight,
    required this.accentDark,
    required this.onAccent,
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.shadowDark,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.divider,
  });

  final Color accent;
  final Color accentLight;
  final Color accentDark;
  final Color onAccent;
  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color shadowDark;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color divider;

  /// Borda fina (1px @ alpha ~0.10) derivada do neutro escuro.
  Color get border => shadowDark.withValues(alpha: 0.10);
  Color get borderStrong => shadowDark.withValues(alpha: 0.18);

  /// Paleta clara derivada de um [brand] (seed). `accentLight`/`accentDark`
  /// são derivados por luminância, salvo override explícito.
  factory PrimeColors.light(
    Color brand, {
    Color? accentLight,
    Color? accentDark,
    Color onAccent = PrimePalette.onAccent,
  }) => PrimeColors(
    accent: brand,
    accentLight: accentLight ?? _lighten(brand),
    accentDark: accentDark ?? _darken(brand),
    onAccent: onAccent,
    background: PrimePalette.background,
    surface: PrimePalette.surface,
    surfaceAlt: PrimePalette.surfaceAlt,
    shadowDark: PrimePalette.shadowDark,
    textPrimary: PrimePalette.textPrimary,
    textSecondary: PrimePalette.textSecondary,
    textMuted: PrimePalette.textMuted,
    divider: PrimePalette.divider,
  );

  /// Paleta escura derivada de um [brand] (seed).
  factory PrimeColors.dark(
    Color brand, {
    Color? accentLight,
    Color? accentDark,
    Color onAccent = PrimePalette.onAccent,
  }) => PrimeColors(
    accent: brand,
    accentLight: accentLight ?? _lighten(brand),
    accentDark: accentDark ?? _darken(brand),
    onAccent: onAccent,
    background: PrimePalette.backgroundDark,
    surface: PrimePalette.surfaceDark,
    surfaceAlt: PrimePalette.surfaceAltDark,
    shadowDark: PrimePalette.shadowDarkDark,
    textPrimary: PrimePalette.textPrimaryDark,
    textSecondary: PrimePalette.textSecondaryDark,
    textMuted: PrimePalette.textMutedDark,
    divider: PrimePalette.dividerDark,
  );

  @override
  PrimeColors copyWith({
    Color? accent,
    Color? accentLight,
    Color? accentDark,
    Color? onAccent,
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? shadowDark,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? divider,
  }) => PrimeColors(
    accent: accent ?? this.accent,
    accentLight: accentLight ?? this.accentLight,
    accentDark: accentDark ?? this.accentDark,
    onAccent: onAccent ?? this.onAccent,
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceAlt: surfaceAlt ?? this.surfaceAlt,
    shadowDark: shadowDark ?? this.shadowDark,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textMuted: textMuted ?? this.textMuted,
    divider: divider ?? this.divider,
  );

  @override
  PrimeColors lerp(ThemeExtension<PrimeColors>? other, double t) {
    if (other is! PrimeColors) return this;
    return PrimeColors(
      accent: Color.lerp(accent, other.accent, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentDark: Color.lerp(accentDark, other.accentDark, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      shadowDark: Color.lerp(shadowDark, other.shadowDark, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

/// Acesso à paleta resolvida do tema atual via `BuildContext`.
/// Uso: `context.cs.accent`, `context.cs.textPrimary`.
extension PrimeContextColors on BuildContext {
  PrimeColors get cs =>
      Theme.of(this).extension<PrimeColors>() ??
      PrimeColors.light(PrimePalette.defaultBrand);
}
