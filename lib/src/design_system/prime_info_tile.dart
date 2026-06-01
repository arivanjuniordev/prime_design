import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';
import 'prime_icon_box.dart';
import 'prime_pressable.dart';
import 'prime_surface.dart';

/// Tile horizontal genérico: ícone-box + título + subtítulo + trailing.
/// Quando [elevated] e há [onTap], renderiza como [PrimeSurface] elevada e
/// pressionável; senão, InkWell simples ou Padding estático.
class PrimeInfoTile extends StatelessWidget {
  /// Cria um tile horizontal com ícone, título, subtítulo e trailing.
  const PrimeInfoTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.trailing,
    this.onTap,
    this.padding = PrimeSpacing.paddingLg,
    this.borderRadius = PrimeRadius.md,
    this.iconBoxSize = 40,
    this.iconSize = 20,
    this.iconBoxRadius = PrimeRadius.sm,
    this.elevated = true,
  });

  /// Ícone exibido no ícone-box à esquerda.
  final IconData icon;

  /// Cor do ícone (e do fundo tonalizado do ícone-box).
  final Color iconColor;

  /// Texto principal do tile.
  final String title;

  /// Texto secundário opcional, abaixo do título.
  final String? subtitle;

  /// Estilo customizado do título; usa o padrão quando nulo.
  final TextStyle? titleStyle;

  /// Estilo customizado do subtítulo; usa o padrão quando nulo.
  final TextStyle? subtitleStyle;

  /// Widget exibido à direita; quando nulo e há [onTap], mostra um chevron.
  final Widget? trailing;

  /// Callback de toque; quando nulo o tile é estático.
  final VoidCallback? onTap;

  /// Espaçamento interno do tile.
  final EdgeInsetsGeometry padding;

  /// Raio de canto do tile.
  final double borderRadius;

  /// Tamanho (largura/altura) do ícone-box.
  final double iconBoxSize;

  /// Tamanho do ícone dentro do ícone-box.
  final double iconSize;

  /// Raio de canto do ícone-box.
  final double iconBoxRadius;

  /// Se true (e com [onTap]), renderiza como superfície elevada e pressionável.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final defaultTitle = TextStyle(
      fontSize: PrimeText.s14,
      fontWeight: PrimeText.semibold,
      color: cs.textPrimary,
      letterSpacing: -0.2,
    );
    final defaultSub = TextStyle(
      fontSize: PrimeText.s12,
      color: cs.textSecondary,
    );

    final trailingWidget =
        trailing ??
        (onTap != null
            ? Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: cs.textMuted,
              )
            : null);

    final row = Row(
      children: [
        PrimeIconBox(
          icon: icon,
          color: iconColor,
          size: iconBoxSize,
          iconSize: iconSize,
          borderRadius: iconBoxRadius,
        ),
        const SizedBox(width: PrimeSpacing.md + 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle ?? defaultTitle),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: subtitleStyle ?? defaultSub,
                ),
              ],
            ],
          ),
        ),
        ?trailingWidget,
      ],
    );

    if (onTap != null) {
      final content = elevated
          ? PrimeSurface(
              elevation: PrimeElevation.low,
              padding: padding,
              borderRadius: borderRadius,
              child: row,
            )
          : Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius),
              clipBehavior: Clip.antiAlias,
              child: Padding(padding: padding, child: row),
            );
      return PrimePressable(onTap: onTap, child: content);
    }

    if (elevated) {
      return PrimeSurface(
        elevation: PrimeElevation.low,
        padding: padding,
        borderRadius: borderRadius,
        child: row,
      );
    }
    return Padding(padding: padding, child: row);
  }
}
