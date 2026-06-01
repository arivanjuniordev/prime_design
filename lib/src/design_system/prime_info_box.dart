import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';

/// Dica/informação: fundo tonalizado em [color], borda fina colorida, ícone +
/// texto. Mais leve que [PrimeBanner] (sem ícone-box, sem título destacado).
class PrimeInfoBox extends StatelessWidget {
  /// Cria uma caixa de dica/informação com ícone e texto.
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

  /// Ícone exibido à esquerda do texto.
  final IconData icon;

  /// Texto informativo exibido na caixa.
  final String text;

  /// Cor base usada no ícone, no fundo tonalizado e na borda.
  final Color color;

  /// Espaçamento interno da caixa.
  final EdgeInsetsGeometry padding;

  /// Raio de canto da caixa.
  final double borderRadius;

  /// Tamanho do ícone.
  final double iconSize;

  /// Tamanho da fonte do texto.
  final double fontSize;

  /// Opacidade do fundo tonalizado pela [color].
  final double backgroundAlpha;

  /// Opacidade da borda colorida.
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
