import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';
import 'app_icon_box.dart';
import 'app_pressable.dart';
import 'surface.dart';

/// Tile horizontal genérico: ícone-box + título + subtítulo + trailing.
/// Quando [elevated] e há [onTap], renderiza como [PrimeSurface] elevada e
/// pressionável; senão, InkWell simples ou Padding estático.
class PrimeInfoTile extends StatelessWidget {
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

  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double iconBoxSize;
  final double iconSize;
  final double iconBoxRadius;
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
