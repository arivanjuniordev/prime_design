import 'package:flutter/material.dart';

/// Escala tipográfica unificada. Presets SEM cor — herdam do Theme.textTheme.
class PrimeText {
  PrimeText._();

  /// Tamanho de fonte 10px.
  static const double s10 = 10;

  /// Tamanho de fonte 11px.
  static const double s11 = 11;

  /// Tamanho de fonte 12px.
  static const double s12 = 12;

  /// Tamanho de fonte 13px.
  static const double s13 = 13;

  /// Tamanho de fonte 14px.
  static const double s14 = 14;

  /// Tamanho de fonte 15px.
  static const double s15 = 15;

  /// Tamanho de fonte 16px.
  static const double s16 = 16;

  /// Tamanho de fonte 18px.
  static const double s18 = 18;

  /// Tamanho de fonte 20px.
  static const double s20 = 20;

  /// Tamanho de fonte 22px.
  static const double s22 = 22;

  /// Tamanho de fonte 28px.
  static const double s28 = 28;

  /// Tamanho de fonte 32px.
  static const double s32 = 32;

  /// Peso regular (w500).
  static const FontWeight regular = FontWeight.w500;

  /// Peso médio (w600).
  static const FontWeight medium = FontWeight.w600;

  /// Peso semibold (w700).
  static const FontWeight semibold = FontWeight.w700;

  /// Peso bold (w800).
  static const FontWeight bold = FontWeight.w800;

  /// Eyebrow / kicker — rótulo em caixa alta acima de títulos (11px, bold).
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

  /// Título de cartão (16px, bold).
  static const TextStyle cardTitle = TextStyle(
    fontSize: s16,
    fontWeight: bold,
    letterSpacing: -0.3,
  );

  /// Título de seção (18px, bold).
  static const TextStyle sectionTitle = TextStyle(
    fontSize: s18,
    fontWeight: bold,
    letterSpacing: -0.3,
  );

  /// Display — destaque grande (28px, bold) para hero/headers.
  static const TextStyle display = TextStyle(
    fontSize: s28,
    fontWeight: bold,
    letterSpacing: -0.8,
    height: 1.15,
  );

  /// Número de estatística / métrica em destaque (22px, bold).
  static const TextStyle stat = TextStyle(
    fontSize: s22,
    fontWeight: bold,
    letterSpacing: -0.5,
  );
}
