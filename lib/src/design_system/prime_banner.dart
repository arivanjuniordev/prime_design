import 'package:flutter/material.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_text.dart';
import '../theme/prime_tokens.dart';
import 'prime_icon_box.dart';

/// Banner horizontal: ícone-box + título + mensagem opcional + trailing.
/// Fundo tonalizado pela [color], borda fina colorida. Flat, sem sombra.
class PrimeBanner extends StatelessWidget {
  const PrimeBanner({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    this.message,
    this.trailing,
    this.onTap,
    this.padding = PrimeSpacing.paddingMd,
    this.borderRadius = PrimeRadius.md,
    this.backgroundAlpha = 0.08,
    this.borderAlpha = 0.22,
  });

  final IconData icon;
  final String title;
  final Color color;
  final String? message;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double backgroundAlpha;
  final double borderAlpha;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final radius = BorderRadius.circular(borderRadius);

    Widget body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: backgroundAlpha),
        borderRadius: radius,
        border: Border.all(
          color: color.withValues(alpha: borderAlpha),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          PrimeIconBox(
            icon: icon,
            color: color,
            size: 36,
            iconSize: 18,
            borderRadius: PrimeRadius.sm - 2,
            backgroundAlpha: 0.18,
          ),
          const SizedBox(width: PrimeSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: PrimeText.s14,
                    fontWeight: PrimeText.bold,
                    color: cs.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    message!,
                    style: TextStyle(
                      fontSize: PrimeText.s12,
                      height: 1.4,
                      color: cs.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );

    if (onTap != null) {
      body = Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(onTap: onTap, borderRadius: radius, child: body),
      );
    }
    return body;
  }
}
