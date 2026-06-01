import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Escala de raios.
class AppRadius {
  AppRadius._();
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double pill = 999;
}

/// Escala de espaçamento (múltiplos de 4).
class AppSpacing {
  AppSpacing._();
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
enum AppElevation { none, flat, low, medium, high }

extension AppElevationX on AppElevation {
  List<BoxShadow> shadows(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = context.cs.shadowDark;
    switch (this) {
      case AppElevation.none:
      case AppElevation.flat:
        return const [];
      case AppElevation.low:
        return [
          BoxShadow(
            color: base.withValues(alpha: isDark ? 0.30 : 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
      case AppElevation.medium:
        return [
          BoxShadow(
            color: base.withValues(alpha: isDark ? 0.40 : 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ];
      case AppElevation.high:
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

class AppMotion {
  AppMotion._();
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

enum Breakpoint {
  compact,
  medium,
  expanded,
  large;

  bool get isCompact => this == Breakpoint.compact;
  bool get isAtLeastMedium => index >= Breakpoint.medium.index;
  bool get isAtLeastExpanded => index >= Breakpoint.expanded.index;

  static Breakpoint fromWidth(double width) {
    if (width < 600) return Breakpoint.compact;
    if (width < 840) return Breakpoint.medium;
    if (width < 1200) return Breakpoint.expanded;
    return Breakpoint.large;
  }

  static Breakpoint of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);
}
