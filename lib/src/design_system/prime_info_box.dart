import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';

/// Dica/informação: fundo tonalizado em [color], borda fina colorida, ícone +
/// texto. Mais leve que [PrimeBanner] (sem ícone-box, sem título destacado).
class PrimeInfoBox extends StatelessWidget {
  const PrimeInfoBox({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.padding = PrimeSpacing.paddingMd,
    this.borderRadius = PrimeRadius.md,
    this.iconSize = 18,
    this.fontSize = PrimeText.s13,
    this.backgroundAlpha = 0.08,
    this.borderAlpha = 0.22,
  });

  final IconData icon;
  final String text;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double iconSize;
  final double fontSize;
  final double backgroundAlpha;
  final double borderAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: backgroundAlpha),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color.withValues(alpha: borderAlpha),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: iconSize, color: color),
          const SizedBox(width: PrimeSpacing.sm + 2),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.45,
                color: context.cs.textPrimary,
                fontWeight: PrimeText.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
