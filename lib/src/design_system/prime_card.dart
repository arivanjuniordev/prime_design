import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';
import 'prime_pressable.dart';

/// Card flat com borda fina + sombra opcional. Passe [onTap] pra versão
/// interativa — usa [PrimePressable] (scale-down + haptic + drag-out cancel).
class PrimeCard extends StatelessWidget {
  /// Cria um card flat, opcionalmente interativo via [onTap]/[onLongPress].
  const PrimeCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      horizontal: PrimeSpacing.lg,
      vertical: PrimeSpacing.md,
    ),
    this.borderRadius = PrimeRadius.md,
    this.color,
    this.elevation = PrimeElevation.low,
    this.onTap,
    this.onLongPress,
  });

  /// Conteúdo do card.
  final Widget child;

  /// Espaçamento interno do card.
  final EdgeInsetsGeometry padding;

  /// Raio de arredondamento das bordas.
  final double borderRadius;

  /// Cor de fundo. `null` → `context.cs.surface`.
  final Color? color;

  /// Nível de elevação (sombra) do card.
  final PrimeElevation elevation;

  /// Callback ao tocar; quando definido torna o card interativo.
  final VoidCallback? onTap;

  /// Callback ao pressionar e segurar; quando definido torna o card interativo.
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final radius = BorderRadius.circular(borderRadius);

    final body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? cs.surface,
        borderRadius: radius,
        border: Border.all(color: cs.border, width: 1),
        boxShadow: elevation.shadows(context),
      ),
      child: child,
    );

    if (onTap == null && onLongPress == null) return body;

    return PrimePressable(onTap: onTap, onLongPress: onLongPress, child: body);
  }
}
