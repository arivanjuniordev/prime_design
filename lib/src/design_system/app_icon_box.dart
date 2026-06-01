import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Quadrado arredondado com ícone sobre fundo tonalizado em [color].
///
/// Fundo: `color.withValues(alpha: backgroundAlpha)`. Sem borda, sem sombra.
class AppIconBox extends StatelessWidget {
  const AppIconBox({
    super.key,
    required this.icon,
    required this.color,
    this.size = 32,
    this.iconSize = 18,
    this.borderRadius = AppRadius.sm,
    this.backgroundAlpha = 0.12,
  });

  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;
  final double borderRadius;
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
