import 'package:flutter/material.dart';
import 'prime_colors.dart';

/// Escala de raios.
class PrimeRadius {
  PrimeRadius._();
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double pill = 999;
}

/// Escala de espaçamento (múltiplos de 4).
class PrimeSpacing {
  PrimeSpacing._();
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  // Helpers de inset comuns.
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
}

/// Elevação semântica única (flat). Cada nível: 1 sombra suave + borda 1px.
enum PrimeElevation { none, flat, low, medium, high }

extension PrimeElevationX on PrimeElevation {
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

class PrimeMotion {
  PrimeMotion._();
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 320);
  static const Curve curve = Curves.easeOutCubic;

  /// Variantes que respeitam Reduce Motion (iOS) / "Remover animações"
  /// (Android) via [MediaQuery.disableAnimationsOf]. Use em animações de UI.
  static Duration fastOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : fast;
  static Duration normalOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : normal;
  static Duration slowOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : slow;
  static Curve curveOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context) ? Curves.linear : curve;
}

enum PrimeBreakpoint {
  compact,
  medium,
  expanded,
  large;

  bool get isCompact => this == PrimeBreakpoint.compact;
  bool get isAtLeastMedium => index >= PrimeBreakpoint.medium.index;
  bool get isAtLeastExpanded => index >= PrimeBreakpoint.expanded.index;

  static PrimeBreakpoint fromWidth(double width) {
    if (width < 600) return PrimeBreakpoint.compact;
    if (width < 840) return PrimeBreakpoint.medium;
    if (width < 1200) return PrimeBreakpoint.expanded;
    return PrimeBreakpoint.large;
  }

  static PrimeBreakpoint of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);
}
