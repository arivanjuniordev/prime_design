import 'package:flutter/material.dart';

/// Escala tipográfica unificada. Presets SEM cor — herdam do Theme.textTheme.
class AppText {
  AppText._();

  static const double s10 = 10;
  static const double s11 = 11;
  static const double s12 = 12;
  static const double s13 = 13;
  static const double s14 = 14;
  static const double s15 = 15;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s22 = 22;
  static const double s28 = 28;
  static const double s32 = 32;

  static const FontWeight regular = FontWeight.w500;
  static const FontWeight medium = FontWeight.w600;
  static const FontWeight semibold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w800;

  static const TextStyle eyebrow = TextStyle(
    fontSize: s11,
    fontWeight: bold,
    letterSpacing: 1.5,
  );

  /// Eyebrow com cor explícita (kicker colorido).
  static TextStyle eyebrowColored(Color color) => TextStyle(
    fontSize: s11,
    fontWeight: bold,
    color: color,
    letterSpacing: 1.5,
  );

  /// Caption / texto auxiliar.
  static const TextStyle caption = TextStyle(fontSize: s12, height: 1.4);

  /// Body text padrão.
  static const TextStyle body = TextStyle(fontSize: s13, height: 1.5);

  /// Body médio (informações secundárias visíveis).
  static const TextStyle bodyMedium = TextStyle(fontSize: s14, height: 1.5);

  /// Texto de leitura (parágrafos longos).
  static const TextStyle reading = TextStyle(fontSize: s15, height: 1.65);

  /// Título de tile (item de lista, atalho).
  static const TextStyle tileTitle = TextStyle(
    fontSize: s14,
    fontWeight: semibold,
    letterSpacing: -0.2,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: s16,
    fontWeight: bold,
    letterSpacing: -0.3,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: s18,
    fontWeight: bold,
    letterSpacing: -0.3,
  );

  static const TextStyle display = TextStyle(
    fontSize: s28,
    fontWeight: bold,
    letterSpacing: -0.8,
    height: 1.15,
  );

  static const TextStyle stat = TextStyle(
    fontSize: s22,
    fontWeight: bold,
    letterSpacing: -0.5,
  );
}
