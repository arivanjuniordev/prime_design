import 'package:flutter/material.dart';
import 'prime_colors.dart';

/// Escala de raios de borda (border radius) do design system.
class PrimeRadius {
  PrimeRadius._();

  /// Raio extra-pequeno (8px) — chips, tags, elementos compactos.
  static const double xs = 8;

  /// Raio pequeno (12px) — botões e campos.
  static const double sm = 12;

  /// Raio médio (14px) — inputs e cartões pequenos.
  static const double md = 14;

  /// Raio grande (18px) — cartões e superfícies.
  static const double lg = 18;

  /// Raio extra-grande (24px) — sheets e diálogos.
  static const double xl = 24;

  /// Raio máximo (999px) — formato pílula (totalmente arredondado).
  static const double pill = 999;
}

/// Escala de espaçamento (múltiplos de 4) do design system.
class PrimeSpacing {
  PrimeSpacing._();

  /// Espaçamento mínimo (2px).
  static const double xxs = 2;

  /// Espaçamento extra-pequeno (4px).
  static const double xs = 4;

  /// Espaçamento pequeno (8px).
  static const double sm = 8;

  /// Espaçamento médio (12px).
  static const double md = 12;

  /// Espaçamento grande (16px).
  static const double lg = 16;

  /// Espaçamento extra-grande (20px).
  static const double xl = 20;

  /// Espaçamento duplo-grande (24px).
  static const double xxl = 24;

  /// Espaçamento triplo-grande (32px).
  static const double xxxl = 32;

  /// Espaçamento enorme (48px) — separações de seção.
  static const double huge = 48;

  // Helpers de inset comuns.
  /// Inset uniforme pequeno ([sm] = 8px) em todos os lados.
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);

  /// Inset uniforme médio ([md] = 12px) em todos os lados.
  static const EdgeInsets paddingMd = EdgeInsets.all(md);

  /// Inset uniforme grande ([lg] = 16px) em todos os lados.
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);

  /// Inset uniforme extra-grande ([xl] = 20px) em todos os lados.
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
}

/// Elevação semântica única (flat). Cada nível: 1 sombra suave + borda 1px.
enum PrimeElevation {
  /// Sem elevação e sem sombra.
  none,

  /// Plano — superfície rente, sem sombra (apenas borda).
  flat,

  /// Elevação baixa — sombra discreta (cartões, tiles).
  low,

  /// Elevação média — sombra moderada (menus, popovers).
  medium,

  /// Elevação alta — sombra pronunciada (diálogos, sheets).
  high,
}

/// Métodos utilitários para resolver a sombra de cada [PrimeElevation].
extension PrimeElevationX on PrimeElevation {
  /// Lista de [BoxShadow] correspondente ao nível, ajustada ao brilho do tema.
  List<BoxShadow> shadows(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = context.cs.shadowDark;
    switch (this) {
      case PrimeElevation.none:
      case PrimeElevation.flat:
        return const [];
      case PrimeElevation.low:
        return [
          BoxShadow(
            color: base.withValues(alpha: isDark ? 0.30 : 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      case PrimeElevation.medium:
        return [
          BoxShadow(
            color: base.withValues(alpha: isDark ? 0.40 : 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ];
      case PrimeElevation.high:
        return [
          BoxShadow(
            color: base.withValues(alpha: isDark ? 0.50 : 0.18),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ];
    }
  }
}

/// Tokens de movimento (durações e curva) das animações do design system.
class PrimeMotion {
  PrimeMotion._();

  /// Duração rápida (120ms) — micro-interações (toques, hovers).
  static const Duration fast = Duration(milliseconds: 120);

  /// Duração padrão (200ms) — transições comuns de UI.
  static const Duration normal = Duration(milliseconds: 200);

  /// Duração lenta (320ms) — transições amplas (sheets, páginas).
  static const Duration slow = Duration(milliseconds: 320);

  /// Curva padrão de easing (easeOutCubic).
  static const Curve curve = Curves.easeOutCubic;

  /// Variantes que respeitam Reduce Motion (iOS) / "Remover animações"
  /// (Android) via [MediaQuery.disableAnimationsOf]. Use em animações de UI.
  ///
  /// Versão de [fast] que retorna [Duration.zero] quando animações estão
  /// desativadas.
  static Duration fastOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : fast;

  /// Versão de [normal] que retorna [Duration.zero] quando animações estão
  /// desativadas.
  static Duration normalOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : normal;

  /// Versão de [slow] que retorna [Duration.zero] quando animações estão
  /// desativadas.
  static Duration slowOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : slow;

  /// Versão de [curve] que retorna [Curves.linear] quando animações estão
  /// desativadas.
  static Curve curveOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Curves.linear : curve;
}

/// Pontos de quebra responsivos baseados na largura disponível.
enum PrimeBreakpoint {
  /// Compacto — largura < 600px (celulares).
  compact,

  /// Médio — largura 600–839px (tablets pequenos).
  medium,

  /// Expandido — largura 840–1199px (tablets grandes).
  expanded,

  /// Grande — largura >= 1200px (desktop).
  large;

  /// `true` se o breakpoint atual é [compact].
  bool get isCompact => this == PrimeBreakpoint.compact;

  /// `true` se o breakpoint é [medium] ou maior.
  bool get isAtLeastMedium => index >= PrimeBreakpoint.medium.index;

  /// `true` se o breakpoint é [expanded] ou maior.
  bool get isAtLeastExpanded => index >= PrimeBreakpoint.expanded.index;

  /// Resolve o breakpoint a partir de uma [width] em pixels lógicos.
  static PrimeBreakpoint fromWidth(double width) {
    if (width < 600) return PrimeBreakpoint.compact;
    if (width < 840) return PrimeBreakpoint.medium;
    if (width < 1200) return PrimeBreakpoint.expanded;
    return PrimeBreakpoint.large;
  }

  /// Resolve o breakpoint a partir da largura da tela no [context].
  static PrimeBreakpoint of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);
}
