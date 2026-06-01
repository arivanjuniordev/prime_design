import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';

/// Container base flat (estilo guitarra_pro_z). Fundo [color] (default =
/// surface do tema), borda 1px sutil e sombra única opcional via [elevation].
/// Sem gradientes, sem double-shadow.
///
/// Para versões interativas (tap/scale), envolva com [PrimePressable] ou use
/// [PrimeCard].
class PrimeSurface extends StatelessWidget {
  /// Cria um container base flat com borda e sombra opcionais.
  const PrimeSurface({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = PrimeRadius.lg,
    this.color,
    this.elevation = PrimeElevation.flat,
    this.shape = BoxShape.rectangle,
    this.borderColor,
    this.showBorder = true,
  });

  /// Conteúdo da superfície.
  final Widget child;

  /// Espaçamento interno opcional.
  final EdgeInsetsGeometry? padding;

  /// Raio de arredondamento das bordas.
  final double borderRadius;

  /// Fundo. Default: surface do tema.
  final Color? color;

  /// Nível de elevação (sombra) da superfície.
  final PrimeElevation elevation;

  /// Formato da superfície (retângulo ou círculo).
  final BoxShape shape;

  /// Override da cor da borda. Default: borda neutra do tema.
  final Color? borderColor;

  /// Se false, nenhuma borda é desenhada (use em superfícies sobre brand color).
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final bg = color ?? cs.surface;
    final radius = shape == BoxShape.circle
        ? null
        : BorderRadius.circular(borderRadius);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        shape: shape,
        border: showBorder
            ? Border.all(color: borderColor ?? cs.border, width: 1)
            : null,
        boxShadow: elevation.shadows(context),
      ),
      child: child,
    );
  }
}
