import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';

/// Pill estática (não-selecionável): ícone + texto pequeno em fundo neutro.
///
/// Para versão selecionável use [PrimeChip]. Para tag UPPERCASE com cor vibrante
/// use [PrimeBadge].
class PrimePill extends StatelessWidget {
  const PrimePill({
    super.key,
    required this.icon,
    required this.text,
    this.padding = const EdgeInsets.symmetric(
      horizontal: PrimeSpacing.sm + 2,
      vertical: PrimeSpacing.xs + 2,
    ),
    this.borderRadius = PrimeRadius.sm,
    this.iconSize = 13,
    this.fontSize = PrimeText.s12,
    this.color,
  });

  final IconData icon;
  final String text;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double iconSize;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final fg = color ?? cs.textSecondary;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: cs.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: fg),
          const SizedBox(width: PrimeSpacing.xs + 1),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: PrimeText.medium,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
