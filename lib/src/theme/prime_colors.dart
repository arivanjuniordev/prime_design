import 'package:flutter/material.dart';

/// Constantes neutras e semânticas do design system (flat, estilo guitarra_pro_z).
///
/// **Neutros e semânticos são fixos** — não variam por marca. A cor de marca
/// (accent) é parametrizável e vive em [PrimeColors] (um [ThemeExtension]),
/// acessada via `context.cs.accent`.
class PrimePalette {
  PrimePalette._();

  // ===== Neutros — Light =====
  /// Fundo da tela (tema claro).
  static const Color background = Color(0xFFF5F6F8);

  /// Superfície primária — cartões e painéis (tema claro).
  static const Color surface = Color(0xFFFFFFFF);

  /// Superfície alternativa — fundos sutis e inputs (tema claro).
  static const Color surfaceAlt = Color(0xFFF0F2F5);

  /// Cor-base das sombras (tema claro).
  static const Color shadowDark = Color(0xFF1F2330);

  /// Texto primário — alto contraste (tema claro).
  static const Color textPrimary = Color(0xFF101218);

  /// Texto secundário — contraste médio (tema claro).
  static const Color textSecondary = Color(0xFF4B5163);

  /// Texto atenuado — baixo contraste / placeholders (tema claro).
  static const Color textMuted = Color(0xFF6B7280);

  /// Cor de divisores e bordas finas (tema claro).
  static const Color divider = Color(0xFFE5E7EB);

  // ===== Neutros — Dark =====
  /// Fundo da tela (tema escuro).
  static const Color backgroundDark = Color(0xFF0E1014);

  /// Superfície primária — cartões e painéis (tema escuro).
  static const Color surfaceDark = Color(0xFF181B22);

  /// Superfície alternativa — fundos sutis e inputs (tema escuro).
  static const Color surfaceAltDark = Color(0xFF1F232C);

  /// Cor-base das sombras (tema escuro).
  static const Color shadowDarkDark = Color(0xFF000000);

  /// Texto primário — alto contraste (tema escuro).
  static const Color textPrimaryDark = Color(0xFFEDEFF5);

  /// Texto secundário — contraste médio (tema escuro).
  static const Color textSecondaryDark = Color(0xFFB2B8C5);

  /// Texto atenuado — baixo contraste / placeholders (tema escuro).
  static const Color textMutedDark = Color(0xFF7B8294);

  /// Cor de divisores e bordas finas (tema escuro).
  static const Color dividerDark = Color(0xFF2D3142);

  // ===== Semânticos (fixos) =====
  // Tons escolhidos para WCAG AA (texto branco ≥ 4.5:1 em badge/chip sólido).
  /// Cor de erro / estado destrutivo.
  static const Color error = Color(0xFFD92D20);

  /// Cor de alerta / atenção.
  static const Color warning = Color(0xFFB45309);

  /// Cor de sucesso / confirmação.
  static const Color success = Color(0xFF047857);

  /// Cor informativa.
  static const Color info = Color(0xFF2563EB);

  /// Cor de conteúdo sobre a marca (texto/ícones em cima do accent).
  static const Color onAccent = Colors.white;

  /// Cor do scrim (overlay escurecedor de modais/sheets).
  static const Color scrim = Color(0xFF000000);

  /// Marca padrão do package (verde esmeralda). Apps passam a sua via
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
  /// Cria uma paleta resolvida com todas as cores explicitamente informadas.
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

  /// Cor de marca (accent) principal.
  final Color accent;

  /// Variante clara da marca (derivada por luminância).
  final Color accentLight;

  /// Variante escura da marca (derivada por luminância).
  final Color accentDark;

  /// Cor de conteúdo sobre a marca (texto/ícones em cima do accent).
  final Color onAccent;

  /// Fundo da tela.
  final Color background;

  /// Superfície primária — cartões e painéis.
  final Color surface;

  /// Superfície alternativa — fundos sutis e inputs.
  final Color surfaceAlt;

  /// Cor-base das sombras.
  final Color shadowDark;

  /// Texto primário — alto contraste.
  final Color textPrimary;

  /// Texto secundário — contraste médio.
  final Color textSecondary;

  /// Texto atenuado — baixo contraste / placeholders.
  final Color textMuted;

  /// Cor de divisores e bordas finas.
  final Color divider;

  /// Borda fina (1px @ alpha ~0.10) derivada do neutro escuro.
  Color get border => shadowDark.withValues(alpha: 0.10);

  /// Borda mais marcada (alpha ~0.18) derivada do neutro escuro.
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

  /// Retorna uma cópia da paleta substituindo apenas os campos informados.
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

  /// Interpola linearmente entre esta paleta e [other] pelo fator [t].
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
  /// Paleta resolvida do tema atual; cai para a marca padrão se ausente.
  PrimeColors get cs =>
      Theme.of(this).extension<PrimeColors>() ??
      PrimeColors.light(PrimePalette.defaultBrand);
}
