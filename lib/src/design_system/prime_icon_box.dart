import 'package:flutter/material.dart';

import '../theme/prime_tokens.dart';

/// Quadrado arredondado com ícone sobre fundo tonalizado em [color].
///
/// Fundo: `color.withValues(alpha: backgroundAlpha)`. Sem borda, sem sombra.
class PrimeIconBox extends StatelessWidget {
  /// Cria um box arredondado com ícone sobre fundo tonalizado.
  const PrimeIconBox({
    super.key,
    required this.icon,
    required this.color,
    this.size = 32,
    this.iconSize = 18,
    this.borderRadius = PrimeRadius.sm,
    this.backgroundAlpha = 0.12,
  });

  /// Ícone exibido no centro do box.
  final IconData icon;

  /// Cor do ícone e base do fundo tonalizado.
  final Color color;

  /// Largura e altura do box.
  final double size;

  /// Tamanho do ícone.
  final double iconSize;

  /// Raio de arredondamento das bordas.
  final double borderRadius;

  /// Opacidade aplicada a [color] para o fundo.
  final double backgroundAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: backgroundAlpha),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, size: iconSize, color: color),
    );
  }
}
