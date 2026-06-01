import 'package:flutter/material.dart';
import 'prime_colors.dart';
import 'prime_tokens.dart';

/// Construtor de tema do design system Prime (flat 2026, Inter).
///
/// A **cor de marca** é parametrizável: cada app passa a sua via [brand].
/// A paleta resolvida é exposta como [PrimeColors] em `theme.extensions`,
/// acessível por `context.cs`.
///
/// A fonte Inter é bundlada no package (`packages/prime_design/Inter`); um app
/// pode sobrescrever passando [fontFamily].
class PrimeTheme {
  PrimeTheme._();

  /// Família da fonte Inter empacotada neste package.
  static const String interFontFamily = 'packages/prime_design/Inter';

  /// Constrói o tema claro para a cor de marca [brand], com [fontFamily]
  /// opcional (padrão: Inter empacotada).
  static ThemeData light({
    Color brand = PrimePalette.defaultBrand,
    String? fontFamily,
  }) => _build(Brightness.light, brand, fontFamily ?? interFontFamily);

  /// Constrói o tema escuro para a cor de marca [brand], com [fontFamily]
  /// opcional (padrão: Inter empacotada).
  static ThemeData dark({
    Color brand = PrimePalette.defaultBrand,
    String? fontFamily,
  }) => _build(Brightness.dark, brand, fontFamily ?? interFontFamily);

  static ThemeData _build(Brightness brightness, Color brand, String fontFamily) {
    final isDark = brightness == Brightness.dark;
    final base = isDark ? ThemeData.dark() : ThemeData.light();
    final colors =
        isDark ? PrimeColors.dark(brand) : PrimeColors.light(brand);

    final textTheme = base.textTheme.apply(
      fontFamily: fontFamily,
      bodyColor: colors.textPrimary,
      displayColor: colors.textPrimary,
    );

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.accent,
      onPrimary: colors.onAccent,
      secondary: colors.accentLight,
      onSecondary: colors.onAccent,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      outline: colors.textMuted,
      outlineVariant: colors.border,
      error: PrimePalette.error,
      onError: Colors.white,
    );

    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: colorScheme,
      extensions: [colors],
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: colors.textPrimary,
          height: 1.5,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: colors.textSecondary,
          height: 1.5,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          color: colors.textMuted,
          height: 1.5,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: colors.textPrimary),
      splashFactory: InkSparkle.splashFactory,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: colors.accent.withValues(alpha: 0.14),
        height: 64,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            color: selected ? colors.accent : colors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 22,
            color: selected ? colors.accent : colors.textSecondary,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surface,
        selectedIconTheme: IconThemeData(color: colors.accent),
        unselectedIconTheme: IconThemeData(color: colors.textSecondary),
        selectedLabelTextStyle: TextStyle(
          color: colors.accent,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: colors.textSecondary,
          fontSize: 12,
        ),
        indicatorColor: colors.accent.withValues(alpha: 0.14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceAlt,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.accent, width: 1.5),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PrimeRadius.lg),
        ),
        headerBackgroundColor: colors.accent,
        headerForegroundColor: colors.onAccent,
        dayStyle: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
        weekdayStyle: textTheme.bodySmall?.copyWith(color: colors.textMuted),
        yearStyle: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.onAccent;
          return colors.textPrimary;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.accent;
          return null;
        }),
        todayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.onAccent;
          return colors.accent;
        }),
        todayBorder: BorderSide(color: colors.accent, width: 1.5),
        yearForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.onAccent;
          return colors.textPrimary;
        }),
        yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.accent;
          return null;
        }),
        rangeSelectionBackgroundColor: colors.accent.withValues(alpha: 0.14),
        dividerColor: colors.divider,
        shadowColor: Colors.transparent,
      ),
      switchTheme: SwitchThemeData(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return colors.surface;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return colors.accent;
          return colors.border;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.transparent;
          return colors.border;
        }),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        space: 1,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.surface,
        contentTextStyle: TextStyle(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
