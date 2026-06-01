import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Container base flat (estilo guitarra_pro_z). Fundo [color] (default =
/// surface do tema), borda 1px sutil e sombra única opcional via [elevation].
/// Sem gradientes, sem double-shadow.
///
/// Para versões interativas (tap/scale), envolva com [PrimePressable] ou use
/// [PrimeCard].
class PrimeSurface extends StatelessWidget {
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

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  /// Fundo. Default: surface do tema.
  final Color? color;
  final PrimeElevation elevation;
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
